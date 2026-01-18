<?php

use App\Models\Ticket;
use App\Models\User;
use App\Models\Device;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Spatie\Permission\Models\Role;

uses(RefreshDatabase::class);

beforeEach(function () {
    // Create super_admin role for TicketObserver
    Role::firstOrCreate(['name' => 'super_admin', 'guard_name' => 'web']);

    // Create a user for testing
    $this->user = User::factory()->create();
});

describe('Ticket Model', function () {

    describe('Ticket Number Generation', function () {

        it('generates ticket number automatically on create', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Ticket',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'open',
                'category' => 'hardware',
            ]);

            expect($ticket->ticket_number)->not->toBeNull();
            expect($ticket->ticket_number)->toStartWith('TKT-');
        });

        it('generates ticket number with correct format', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Ticket',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'open',
                'category' => 'software',
            ]);

            $expectedPrefix = 'TKT-' . now()->format('Ymd');
            expect($ticket->ticket_number)->toStartWith($expectedPrefix);
            expect($ticket->ticket_number)->toMatch('/^TKT-\d{8}-\d{4}$/');
        });

        it('increments sequence number for tickets created on same day', function () {
            $ticket1 = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'First Ticket',
                'description' => 'Description 1',
                'priority' => 'low',
                'status' => 'open',
                'category' => 'hardware',
            ]);

            $ticket2 = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Second Ticket',
                'description' => 'Description 2',
                'priority' => 'high',
                'status' => 'open',
                'category' => 'software',
            ]);

            $seq1 = (int) substr($ticket1->ticket_number, -4);
            $seq2 = (int) substr($ticket2->ticket_number, -4);

            expect($seq2)->toBe($seq1 + 1);
        });
    });

    describe('Priority Color Accessor', function () {

        it('returns danger for critical priority', function () {
            $ticket = new Ticket(['priority' => 'critical']);
            expect($ticket->priority_color)->toBe('danger');
        });

        it('returns warning for high priority', function () {
            $ticket = new Ticket(['priority' => 'high']);
            expect($ticket->priority_color)->toBe('warning');
        });

        it('returns info for medium priority', function () {
            $ticket = new Ticket(['priority' => 'medium']);
            expect($ticket->priority_color)->toBe('info');
        });

        it('returns gray for low priority', function () {
            $ticket = new Ticket(['priority' => 'low']);
            expect($ticket->priority_color)->toBe('gray');
        });

        it('returns gray for unknown priority', function () {
            $ticket = new Ticket(['priority' => 'unknown']);
            expect($ticket->priority_color)->toBe('gray');
        });
    });

    describe('Status Color Accessor', function () {

        it('returns danger for open status', function () {
            $ticket = new Ticket(['status' => 'open']);
            expect($ticket->status_color)->toBe('danger');
        });

        it('returns warning for in_progress status', function () {
            $ticket = new Ticket(['status' => 'in_progress']);
            expect($ticket->status_color)->toBe('warning');
        });

        it('returns info for waiting_for_user status', function () {
            $ticket = new Ticket(['status' => 'waiting_for_user']);
            expect($ticket->status_color)->toBe('info');
        });

        it('returns success for resolved status', function () {
            $ticket = new Ticket(['status' => 'resolved']);
            expect($ticket->status_color)->toBe('success');
        });

        it('returns gray for closed status', function () {
            $ticket = new Ticket(['status' => 'closed']);
            expect($ticket->status_color)->toBe('gray');
        });
    });

    describe('Category Label Accessor', function () {

        it('returns Hardware for hardware category', function () {
            $ticket = new Ticket(['category' => 'hardware']);
            expect($ticket->category_label)->toBe('Hardware');
        });

        it('returns Software for software category', function () {
            $ticket = new Ticket(['category' => 'software']);
            expect($ticket->category_label)->toBe('Software');
        });

        it('returns Jaringan for network category', function () {
            $ticket = new Ticket(['category' => 'network']);
            expect($ticket->category_label)->toBe('Jaringan');
        });

        it('returns Printer for printer category', function () {
            $ticket = new Ticket(['category' => 'printer']);
            expect($ticket->category_label)->toBe('Printer');
        });

        it('returns Lainnya for other category', function () {
            $ticket = new Ticket(['category' => 'other']);
            expect($ticket->category_label)->toBe('Lainnya');
        });
    });

    describe('Priority Label Accessor', function () {

        it('returns Kritis for critical priority', function () {
            $ticket = new Ticket(['priority' => 'critical']);
            expect($ticket->priority_label)->toBe('Kritis');
        });

        it('returns Tinggi for high priority', function () {
            $ticket = new Ticket(['priority' => 'high']);
            expect($ticket->priority_label)->toBe('Tinggi');
        });

        it('returns Sedang for medium priority', function () {
            $ticket = new Ticket(['priority' => 'medium']);
            expect($ticket->priority_label)->toBe('Sedang');
        });

        it('returns Rendah for low priority', function () {
            $ticket = new Ticket(['priority' => 'low']);
            expect($ticket->priority_label)->toBe('Rendah');
        });
    });

    describe('Status Label Accessor', function () {

        it('returns Dibuka for open status', function () {
            $ticket = new Ticket(['status' => 'open']);
            expect($ticket->status_label)->toBe('Dibuka');
        });

        it('returns Diproses for in_progress status', function () {
            $ticket = new Ticket(['status' => 'in_progress']);
            expect($ticket->status_label)->toBe('Diproses');
        });

        it('returns Menunggu User for waiting_for_user status', function () {
            $ticket = new Ticket(['status' => 'waiting_for_user']);
            expect($ticket->status_label)->toBe('Menunggu User');
        });

        it('returns Selesai for resolved status', function () {
            $ticket = new Ticket(['status' => 'resolved']);
            expect($ticket->status_label)->toBe('Selesai');
        });

        it('returns Ditutup for closed status', function () {
            $ticket = new Ticket(['status' => 'closed']);
            expect($ticket->status_label)->toBe('Ditutup');
        });
    });

    describe('Helper Methods', function () {

        it('isOpen returns true for open status', function () {
            $ticket = new Ticket(['status' => 'open']);
            expect($ticket->isOpen())->toBeTrue();
        });

        it('isOpen returns true for in_progress status', function () {
            $ticket = new Ticket(['status' => 'in_progress']);
            expect($ticket->isOpen())->toBeTrue();
        });

        it('isOpen returns true for waiting_for_user status', function () {
            $ticket = new Ticket(['status' => 'waiting_for_user']);
            expect($ticket->isOpen())->toBeTrue();
        });

        it('isOpen returns false for resolved status', function () {
            $ticket = new Ticket(['status' => 'resolved']);
            expect($ticket->isOpen())->toBeFalse();
        });

        it('isOpen returns false for closed status', function () {
            $ticket = new Ticket(['status' => 'closed']);
            expect($ticket->isOpen())->toBeFalse();
        });

        it('canBeEdited returns true for non-closed status', function () {
            $ticket = new Ticket(['status' => 'open']);
            expect($ticket->canBeEdited())->toBeTrue();

            $ticket->status = 'in_progress';
            expect($ticket->canBeEdited())->toBeTrue();

            $ticket->status = 'resolved';
            expect($ticket->canBeEdited())->toBeTrue();
        });

        it('canBeEdited returns false for closed status', function () {
            $ticket = new Ticket(['status' => 'closed']);
            expect($ticket->canBeEdited())->toBeFalse();
        });

        it('markAsResolved updates status and resolved_at', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Ticket',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'in_progress',
                'category' => 'hardware',
            ]);

            $ticket->markAsResolved('Issue fixed');

            expect($ticket->fresh()->status)->toBe('resolved');
            expect($ticket->fresh()->resolution_notes)->toBe('Issue fixed');
            expect($ticket->fresh()->resolved_at)->not->toBeNull();
        });

        it('close updates status and closed_at', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Ticket',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'resolved',
                'category' => 'hardware',
            ]);

            $ticket->close();

            expect($ticket->fresh()->status)->toBe('closed');
            expect($ticket->fresh()->closed_at)->not->toBeNull();
        });
    });

    describe('Relationships', function () {

        it('belongs to a user', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Ticket',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'open',
                'category' => 'hardware',
            ]);

            expect($ticket->user)->toBeInstanceOf(User::class);
            expect($ticket->user->id)->toBe($this->user->id);
        });
    });
});
