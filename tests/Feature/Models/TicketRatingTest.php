<?php

use App\Enums\TicketStatus;
use App\Models\Ticket;
use App\Models\TicketRating;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Spatie\Permission\Models\Role;

uses(RefreshDatabase::class);

beforeEach(function () {
    Role::firstOrCreate(['name' => 'super_admin', 'guard_name' => 'web']);
    Role::firstOrCreate(['name' => 'Admin', 'guard_name' => 'web']);
    Role::firstOrCreate(['name' => 'Member', 'guard_name' => 'web']);

    $this->user = User::factory()->create();
    $this->admin = User::factory()->create();
    $this->admin->assignRole('Admin');
});

describe('Ticket Rating', function () {

    describe('canBeRated()', function () {

        it('returns true when ticket is resolved and has no rating', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::Resolved->value,
                'category' => 'hardware',
                'resolved_at' => now(),
            ]);

            expect($ticket->canBeRated())->toBeTrue();
        });

        it('returns false when ticket is not resolved', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::Open->value,
                'category' => 'hardware',
            ]);

            expect($ticket->canBeRated())->toBeFalse();
        });

        it('returns false when ticket is closed', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::Closed->value,
                'category' => 'hardware',
                'closed_at' => now(),
            ]);

            expect($ticket->canBeRated())->toBeFalse();
        });

        it('returns false when ticket already has a rating', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::Resolved->value,
                'category' => 'hardware',
                'resolved_at' => now(),
            ]);

            TicketRating::create([
                'ticket_id' => $ticket->id,
                'user_id' => $this->user->id,
                'score' => 5,
            ]);

            expect($ticket->fresh()->canBeRated())->toBeFalse();
        });
    });

    describe('canBeClosedByReporter()', function () {

        it('returns true for the ticket reporter when resolved', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::Resolved->value,
                'category' => 'hardware',
                'resolved_at' => now(),
            ]);

            expect($ticket->canBeClosedByReporter($this->user))->toBeTrue();
        });

        it('returns false for a different user', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::Resolved->value,
                'category' => 'hardware',
                'resolved_at' => now(),
            ]);

            $otherUser = User::factory()->create();

            expect($ticket->canBeClosedByReporter($otherUser))->toBeFalse();
        });

        it('returns false when ticket is not resolved', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::InProgress->value,
                'category' => 'hardware',
            ]);

            expect($ticket->canBeClosedByReporter($this->user))->toBeFalse();
        });
    });

    describe('Rating creation', function () {

        it('creates a rating and associates with ticket', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::Resolved->value,
                'category' => 'hardware',
                'resolved_at' => now(),
            ]);

            $rating = TicketRating::create([
                'ticket_id' => $ticket->id,
                'user_id' => $this->user->id,
                'score' => 4,
                'feedback' => 'Penanganan cepat dan tepat',
            ]);

            expect($rating->ticket->id)->toBe($ticket->id);
            expect($rating->user->id)->toBe($this->user->id);
            expect($rating->score)->toBe(4);
            expect($rating->feedback)->toBe('Penanganan cepat dan tepat');
        });

        it('enforces unique constraint per ticket', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::Resolved->value,
                'category' => 'hardware',
                'resolved_at' => now(),
            ]);

            TicketRating::create([
                'ticket_id' => $ticket->id,
                'user_id' => $this->user->id,
                'score' => 5,
            ]);

            expect(fn () => TicketRating::create([
                'ticket_id' => $ticket->id,
                'user_id' => $this->user->id,
                'score' => 3,
            ]))->toThrow(\Illuminate\Database\QueryException::class);
        });

        it('allows null feedback', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::Resolved->value,
                'category' => 'hardware',
                'resolved_at' => now(),
            ]);

            $rating = TicketRating::create([
                'ticket_id' => $ticket->id,
                'user_id' => $this->user->id,
                'score' => 3,
                'feedback' => null,
            ]);

            expect($rating->feedback)->toBeNull();
        });
    });

    describe('Ticket hasBeenRated()', function () {

        it('returns false when no rating exists', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::Resolved->value,
                'category' => 'hardware',
                'resolved_at' => now(),
            ]);

            expect($ticket->hasBeenRated())->toBeFalse();
        });

        it('returns true when rating exists', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test',
                'description' => 'Test',
                'priority' => 'medium',
                'status' => TicketStatus::Resolved->value,
                'category' => 'hardware',
                'resolved_at' => now(),
            ]);

            TicketRating::create([
                'ticket_id' => $ticket->id,
                'user_id' => $this->user->id,
                'score' => 5,
            ]);

            expect($ticket->fresh()->hasBeenRated())->toBeTrue();
        });
    });
});
