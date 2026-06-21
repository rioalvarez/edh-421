<?php

use App\Enums\TicketStatus;
use App\Models\Ticket;
use App\Models\TicketRating;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Carbon;
use Spatie\Permission\Models\Role;

uses(RefreshDatabase::class);

beforeEach(function () {
    Role::firstOrCreate(['name' => 'super_admin', 'guard_name' => 'web']);

    $this->user = User::factory()->create();
});

describe('tickets:auto-close Command', function () {

    it('closes tickets resolved more than 3 days ago without rating', function () {
        $ticket = Ticket::create([
            'user_id' => $this->user->id,
            'subject' => 'Old resolved ticket',
            'description' => 'Description',
            'priority' => 'low',
            'status' => TicketStatus::Resolved->value,
            'category' => 'hardware',
            'resolved_at' => Carbon::now()->subDays(4),
        ]);

        $this->artisan('tickets:auto-close')
            ->assertExitCode(0);

        expect($ticket->fresh()->status)->toBe(TicketStatus::Closed->value);
        expect($ticket->fresh()->closed_at)->not->toBeNull();
    });

    it('does not close tickets resolved less than 3 days ago', function () {
        $ticket = Ticket::create([
            'user_id' => $this->user->id,
            'subject' => 'Recent resolved ticket',
            'description' => 'Description',
            'priority' => 'medium',
            'status' => TicketStatus::Resolved->value,
            'category' => 'software',
            'resolved_at' => Carbon::now()->subDays(2),
        ]);

        $this->artisan('tickets:auto-close')
            ->assertExitCode(0);

        expect($ticket->fresh()->status)->toBe(TicketStatus::Resolved->value);
    });

    it('does not close tickets that already have a rating', function () {
        $ticket = Ticket::create([
            'user_id' => $this->user->id,
            'subject' => 'Rated ticket',
            'description' => 'Description',
            'priority' => 'medium',
            'status' => TicketStatus::Resolved->value,
            'category' => 'hardware',
            'resolved_at' => Carbon::now()->subDays(5),
        ]);

        TicketRating::create([
            'ticket_id' => $ticket->id,
            'user_id' => $this->user->id,
            'score' => 4,
        ]);

        $this->artisan('tickets:auto-close')
            ->assertExitCode(0);

        // Should still be resolved — the rating action closes it, not auto-close
        expect($ticket->fresh()->status)->toBe(TicketStatus::Resolved->value);
    });

    it('does not close open or in-progress tickets', function () {
        $openTicket = Ticket::create([
            'user_id' => $this->user->id,
            'subject' => 'Open ticket',
            'description' => 'Description',
            'priority' => 'high',
            'status' => TicketStatus::Open->value,
            'category' => 'network',
        ]);

        $inProgressTicket = Ticket::create([
            'user_id' => $this->user->id,
            'subject' => 'In progress ticket',
            'description' => 'Description',
            'priority' => 'medium',
            'status' => TicketStatus::InProgress->value,
            'category' => 'software',
        ]);

        $this->artisan('tickets:auto-close')
            ->assertExitCode(0);

        expect($openTicket->fresh()->status)->toBe(TicketStatus::Open->value);
        expect($inProgressTicket->fresh()->status)->toBe(TicketStatus::InProgress->value);
    });

    it('respects custom days option', function () {
        $ticket = Ticket::create([
            'user_id' => $this->user->id,
            'subject' => 'Custom days test',
            'description' => 'Description',
            'priority' => 'low',
            'status' => TicketStatus::Resolved->value,
            'category' => 'hardware',
            'resolved_at' => Carbon::now()->subDays(6),
        ]);

        // With 7 days threshold, 6-day-old should NOT be closed
        $this->artisan('tickets:auto-close --days=7')
            ->assertExitCode(0);

        expect($ticket->fresh()->status)->toBe(TicketStatus::Resolved->value);

        // With 5 days threshold, 6-day-old SHOULD be closed
        $this->artisan('tickets:auto-close --days=5')
            ->assertExitCode(0);

        expect($ticket->fresh()->status)->toBe(TicketStatus::Closed->value);
    });

    it('outputs message when no tickets to close', function () {
        $this->artisan('tickets:auto-close')
            ->expectsOutput('No tickets to auto-close.')
            ->assertExitCode(0);
    });
});
