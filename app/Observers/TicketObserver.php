<?php

namespace App\Observers;

use App\Enums\TicketStatus;
use App\Models\Ticket;
use App\Models\TicketAuditLog;
use App\Models\User;
use App\Notifications\TicketAssignedNotification;
use App\Notifications\TicketCreatedNotification;
use App\Notifications\TicketStatusChangedNotification;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Notification;

class TicketObserver
{
    /**
     * Clear navigation badge cache for all affected users.
     * Uses batch forget to minimize cache operations.
     */
    protected function clearBadgeCache(Ticket $ticket): void
    {
        $adminIds = Cache::remember('it_admin_ids', now()->addMinutes(10), function () {
            return User::itAdmins()->pluck('id')->all();
        });

        $keysToForget = [];

        // Owner cache
        $keysToForget[] = "ticket_badge_{$ticket->user_id}_user";
        $keysToForget[] = "ticket_badge_color_{$ticket->user_id}_user";

        // Assigned admin cache
        if ($ticket->assigned_to) {
            $keysToForget[] = "ticket_badge_{$ticket->assigned_to}_admin";
            $keysToForget[] = "ticket_badge_color_{$ticket->assigned_to}_admin";
        }

        // All admin caches
        foreach ($adminIds as $adminId) {
            $keysToForget[] = "ticket_badge_{$adminId}_admin";
            $keysToForget[] = "ticket_badge_color_{$adminId}_admin";
        }

        // Batch forget unique keys
        foreach (array_unique($keysToForget) as $key) {
            Cache::forget($key);
        }
    }

    /**
     * Write an audit log entry for the ticket.
     */
    protected function writeAuditLog(Ticket $ticket, string $event, string $description, array $oldValues = [], array $newValues = []): void
    {
        TicketAuditLog::create([
            'ticket_id' => $ticket->id,
            'user_id' => auth()->id(),
            'event' => $event,
            'description' => $description,
            'old_values' => count($oldValues) ? $oldValues : null,
            'new_values' => count($newValues) ? $newValues : null,
        ]);
    }

    /**
     * Handle the Ticket "created" event.
     */
    public function created(Ticket $ticket): void
    {
        $this->clearBadgeCache($ticket);

        $this->writeAuditLog($ticket, 'created', "Tiket {$ticket->ticket_number} dibuat oleh pelapor.", [], [
            'subject' => $ticket->subject,
            'category' => $ticket->category,
            'priority' => $ticket->priority,
        ]);

        // Send queued notifications to all admins except ticket creator
        $admins = User::itAdmins()->where('id', '!=', $ticket->user_id)->get();
        $notification = TicketCreatedNotification::fromTicket($ticket);

        Notification::send($admins, $notification);
    }

    /**
     * Handle the Ticket "updated" event.
     */
    public function updated(Ticket $ticket): void
    {
        if ($ticket->isDirty(['status', 'assigned_to'])) {
            $this->clearBadgeCache($ticket);
        }

        if ($ticket->isDirty('status')) {
            $this->handleStatusChange($ticket);
        }

        if ($ticket->isDirty('assigned_to') && $ticket->assigned_to) {
            $this->handleAssignment($ticket);
        }
    }

    /**
     * Handle the Ticket "deleted" event.
     */
    public function deleted(Ticket $ticket): void
    {
        $this->clearBadgeCache($ticket);
    }

    public function restored(Ticket $ticket): void {}

    public function forceDeleted(Ticket $ticket): void {}

    private function handleStatusChange(Ticket $ticket): void
    {
        $oldStatus = $ticket->getOriginal('status');
        $newStatus = $ticket->status;

        $oldStatusLabel = TicketStatus::tryLabel($oldStatus) ?? $oldStatus;
        $newStatusLabel = TicketStatus::tryLabel($newStatus) ?? $newStatus;

        $this->writeAuditLog(
            $ticket,
            'status_changed',
            "Status berubah dari \"{$oldStatusLabel}\" menjadi \"{$newStatusLabel}\".",
            ['status' => $oldStatus],
            ['status' => $newStatus]
        );

        $notification = TicketStatusChangedNotification::fromTicket($ticket, $newStatus);

        // Notify reporter if they didn't make the change
        $recipients = collect();

        if ($ticket->user_id !== auth()->id()) {
            $reporter = User::find($ticket->user_id);
            if ($reporter) {
                $recipients->push($reporter);
            }
        }

        // Notify assigned admin if they didn't make the change
        if ($ticket->assigned_to && $ticket->assigned_to !== auth()->id()) {
            $assignedUser = User::find($ticket->assigned_to);
            if ($assignedUser) {
                $recipients->push($assignedUser);
            }
        }

        if ($recipients->isNotEmpty()) {
            Notification::send($recipients, $notification);
        }
    }

    private function handleAssignment(Ticket $ticket): void
    {
        $newAssignedUser = User::find($ticket->assigned_to);

        $oldAssigned = $ticket->getOriginal('assigned_to')
            ? (User::find($ticket->getOriginal('assigned_to'))?->name ?? 'Tidak diketahui')
            : 'Belum ditugaskan';

        $this->writeAuditLog(
            $ticket,
            'assigned',
            "Tiket ditugaskan ke {$newAssignedUser?->name}.",
            ['assigned_to' => $oldAssigned],
            ['assigned_to' => $newAssignedUser?->name]
        );

        if (! $newAssignedUser) {
            return;
        }

        // Notify assignee (unless self-assign)
        if ($ticket->assigned_to !== auth()->id()) {
            $newAssignedUser->notify(TicketAssignedNotification::forAssignee($ticket));
        }

        // Notify reporter
        if ($ticket->user_id !== auth()->id()) {
            $ticketOwner = User::find($ticket->user_id);
            if ($ticketOwner) {
                $ticketOwner->notify(TicketAssignedNotification::forReporter($ticket, $newAssignedUser->name));
            }
        }
    }
}
