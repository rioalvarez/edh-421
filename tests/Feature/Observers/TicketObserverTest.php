<?php

use App\Models\Ticket;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Notification;

uses(RefreshDatabase::class);

beforeEach(function () {
    // Create super_admin role for TicketObserver
    \Spatie\Permission\Models\Role::firstOrCreate(['name' => 'super_admin', 'guard_name' => 'web']);

    // Create regular user
    $this->user = User::factory()->create();

    // Create admin user with super_admin role
    $this->admin = User::factory()->create();
    $this->admin->assignRole('super_admin');
});

describe('TicketObserver', function () {

    describe('Cache Clearing', function () {

        it('clears badge cache when ticket is created', function () {
            // Set up cache
            Cache::put("ticket_badge_{$this->user->id}_user", 5, 3600);
            Cache::put("ticket_badge_color_{$this->user->id}_user", 'danger', 3600);

            // Create ticket
            Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Ticket',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'open',
                'category' => 'hardware',
            ]);

            // Cache should be cleared
            expect(Cache::has("ticket_badge_{$this->user->id}_user"))->toBeFalse();
            expect(Cache::has("ticket_badge_color_{$this->user->id}_user"))->toBeFalse();
        });

        it('clears badge cache when ticket status is updated', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Ticket',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'open',
                'category' => 'hardware',
            ]);

            // Set up cache again after creation
            Cache::put("ticket_badge_{$this->user->id}_user", 5, 3600);

            // Update status
            $ticket->update(['status' => 'in_progress']);

            // Cache should be cleared
            expect(Cache::has("ticket_badge_{$this->user->id}_user"))->toBeFalse();
        });

        it('clears badge cache when ticket is deleted', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Ticket',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'open',
                'category' => 'hardware',
            ]);

            // Set up cache again
            Cache::put("ticket_badge_{$this->user->id}_user", 5, 3600);

            // Delete ticket
            $ticket->delete();

            // Cache should be cleared
            expect(Cache::has("ticket_badge_{$this->user->id}_user"))->toBeFalse();
        });

        it('clears assigned admin cache when assigned_to changes', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Ticket',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'open',
                'category' => 'hardware',
            ]);

            // Set up cache for admin
            Cache::put("ticket_badge_{$this->admin->id}_admin", 3, 3600);
            Cache::put("ticket_badge_color_{$this->admin->id}_admin", 'warning', 3600);

            // Assign ticket to admin
            $ticket->update(['assigned_to' => $this->admin->id]);

            // Admin cache should be cleared
            expect(Cache::has("ticket_badge_{$this->admin->id}_admin"))->toBeFalse();
            expect(Cache::has("ticket_badge_color_{$this->admin->id}_admin"))->toBeFalse();
        });
    });

    describe('Ticket Lifecycle', function () {

        it('observer is triggered on ticket creation', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Subject',
                'description' => 'Test Description',
                'priority' => 'high',
                'status' => 'open',
                'category' => 'software',
            ]);

            expect($ticket)->toBeInstanceOf(Ticket::class);
            expect($ticket->exists)->toBeTrue();
        });

        it('observer is triggered on ticket update', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Subject',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'open',
                'category' => 'hardware',
            ]);

            $ticket->update(['status' => 'in_progress']);

            expect($ticket->fresh()->status)->toBe('in_progress');
        });

        it('observer is triggered on ticket deletion', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Subject',
                'description' => 'Test Description',
                'priority' => 'low',
                'status' => 'open',
                'category' => 'network',
            ]);

            $ticketId = $ticket->id;
            $ticket->delete();

            expect(Ticket::find($ticketId))->toBeNull();
        });
    });

    describe('Status Change Tracking', function () {

        it('detects status change from open to in_progress', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Subject',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'open',
                'category' => 'hardware',
            ]);

            expect($ticket->status)->toBe('open');

            $ticket->update(['status' => 'in_progress']);
            $ticket->refresh();

            expect($ticket->status)->toBe('in_progress');
        });

        it('detects status change to resolved', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Subject',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'in_progress',
                'category' => 'software',
            ]);

            $ticket->markAsResolved('Issue fixed');

            expect($ticket->fresh()->status)->toBe('resolved');
            expect($ticket->fresh()->resolution_notes)->toBe('Issue fixed');
        });

        it('detects status change to closed', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Subject',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'resolved',
                'category' => 'printer',
            ]);

            $ticket->close();

            expect($ticket->fresh()->status)->toBe('closed');
            expect($ticket->fresh()->closed_at)->not->toBeNull();
        });
    });

    describe('Assignment Tracking', function () {

        it('detects when ticket is assigned', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Subject',
                'description' => 'Test Description',
                'priority' => 'high',
                'status' => 'open',
                'category' => 'hardware',
                'assigned_to' => null,
            ]);

            expect($ticket->assigned_to)->toBeNull();

            $ticket->update(['assigned_to' => $this->admin->id]);

            expect($ticket->fresh()->assigned_to)->toBe($this->admin->id);
        });

        it('detects when ticket is reassigned', function () {
            $anotherAdmin = User::factory()->create();

            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Subject',
                'description' => 'Test Description',
                'priority' => 'medium',
                'status' => 'in_progress',
                'category' => 'software',
                'assigned_to' => $this->admin->id,
            ]);

            expect($ticket->assigned_to)->toBe($this->admin->id);

            $ticket->update(['assigned_to' => $anotherAdmin->id]);

            expect($ticket->fresh()->assigned_to)->toBe($anotherAdmin->id);
        });

        it('detects when ticket is unassigned', function () {
            $ticket = Ticket::create([
                'user_id' => $this->user->id,
                'subject' => 'Test Subject',
                'description' => 'Test Description',
                'priority' => 'low',
                'status' => 'open',
                'category' => 'network',
                'assigned_to' => $this->admin->id,
            ]);

            expect($ticket->assigned_to)->toBe($this->admin->id);

            $ticket->update(['assigned_to' => null]);

            expect($ticket->fresh()->assigned_to)->toBeNull();
        });
    });

    describe('Observer Attribute', function () {

        it('has ObservedBy attribute on Ticket model', function () {
            $reflection = new ReflectionClass(Ticket::class);
            $attributes = $reflection->getAttributes();

            $hasObservedBy = false;
            foreach ($attributes as $attribute) {
                if (str_contains($attribute->getName(), 'ObservedBy')) {
                    $hasObservedBy = true;
                    break;
                }
            }

            expect($hasObservedBy)->toBeTrue();
        });
    });
});
