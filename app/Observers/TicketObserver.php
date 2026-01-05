<?php

namespace App\Observers;

use App\Models\Ticket;
use App\Models\User;
use Filament\Notifications\Notification;
use Filament\Notifications\Actions\Action;

class TicketObserver
{
    /**
     * Handle the Ticket "created" event.
     */
    public function created(Ticket $ticket): void
    {
        // Notifikasi ke semua admin bahwa ada tiket baru
        $admins = User::role('super_admin')->where('id', '!=', $ticket->user_id)->get();

        foreach ($admins as $admin) {
            Notification::make()
                ->title('Tiket Baru: ' . $ticket->ticket_number)
                ->body($ticket->subject)
                ->icon('heroicon-o-ticket')
                ->iconColor('info')
                ->actions([
                    Action::make('view')
                        ->label('Lihat')
                        ->url(route('filament.admin.resources.tickets.view', $ticket))
                        ->markAsRead(),
                ])
                ->sendToDatabase($admin);
        }
    }

    /**
     * Handle the Ticket "updated" event.
     */
    public function updated(Ticket $ticket): void
    {
        // Cek apakah status berubah
        if ($ticket->isDirty('status')) {
            $oldStatus = $ticket->getOriginal('status');
            $newStatus = $ticket->status;

            $statusLabels = [
                'open' => 'Dibuka',
                'in_progress' => 'Diproses',
                'waiting_for_user' => 'Menunggu User',
                'resolved' => 'Selesai',
                'closed' => 'Ditutup',
            ];

            $statusColors = [
                'open' => 'danger',
                'in_progress' => 'warning',
                'waiting_for_user' => 'info',
                'resolved' => 'success',
                'closed' => 'gray',
            ];

            // Notifikasi ke pelapor jika bukan dia yang mengubah
            if ($ticket->user_id !== auth()->id()) {
                Notification::make()
                    ->title('Status Tiket Diperbarui')
                    ->body("Tiket {$ticket->ticket_number} status berubah menjadi: {$statusLabels[$newStatus]}")
                    ->icon('heroicon-o-arrow-path')
                    ->iconColor($statusColors[$newStatus] ?? 'gray')
                    ->actions([
                        Action::make('view')
                            ->label('Lihat Tiket')
                            ->url(route('filament.admin.resources.tickets.view', $ticket))
                            ->markAsRead(),
                    ])
                    ->sendToDatabase($ticket->user);
            }

            // Notifikasi ke assigned admin jika ada dan bukan dia yang mengubah
            if ($ticket->assigned_to && $ticket->assigned_to !== auth()->id()) {
                Notification::make()
                    ->title('Status Tiket Diperbarui')
                    ->body("Tiket {$ticket->ticket_number} status berubah: {$statusLabels[$oldStatus]} → {$statusLabels[$newStatus]}")
                    ->icon('heroicon-o-arrow-path')
                    ->iconColor($statusColors[$newStatus] ?? 'gray')
                    ->actions([
                        Action::make('view')
                            ->label('Lihat Tiket')
                            ->url(route('filament.admin.resources.tickets.view', $ticket))
                            ->markAsRead(),
                    ])
                    ->sendToDatabase($ticket->assignedTo);
            }
        }

        // Cek apakah tiket di-assign ke seseorang
        if ($ticket->isDirty('assigned_to') && $ticket->assigned_to) {
            // Jangan kirim notifikasi jika self-assign
            if ($ticket->assigned_to !== auth()->id()) {
                Notification::make()
                    ->title('Tiket Ditugaskan ke Anda')
                    ->body("Anda ditugaskan untuk menangani tiket: {$ticket->ticket_number}")
                    ->icon('heroicon-o-user-plus')
                    ->iconColor('warning')
                    ->actions([
                        Action::make('view')
                            ->label('Lihat Tiket')
                            ->url(route('filament.admin.resources.tickets.view', $ticket))
                            ->markAsRead(),
                    ])
                    ->sendToDatabase($ticket->assignedTo);
            }

            // Notifikasi ke pelapor
            if ($ticket->user_id !== auth()->id()) {
                Notification::make()
                    ->title('Tiket Anda Sedang Ditangani')
                    ->body("Tiket {$ticket->ticket_number} sedang ditangani oleh {$ticket->assignedTo->name}")
                    ->icon('heroicon-o-wrench-screwdriver')
                    ->iconColor('success')
                    ->actions([
                        Action::make('view')
                            ->label('Lihat Tiket')
                            ->url(route('filament.admin.resources.tickets.view', $ticket))
                            ->markAsRead(),
                    ])
                    ->sendToDatabase($ticket->user);
            }
        }
    }

    /**
     * Handle the Ticket "deleted" event.
     */
    public function deleted(Ticket $ticket): void
    {
        //
    }

    /**
     * Handle the Ticket "restored" event.
     */
    public function restored(Ticket $ticket): void
    {
        //
    }

    /**
     * Handle the Ticket "force deleted" event.
     */
    public function forceDeleted(Ticket $ticket): void
    {
        //
    }
}
