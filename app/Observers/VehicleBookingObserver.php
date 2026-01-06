<?php

namespace App\Observers;

use App\Models\VehicleBooking;
use App\Models\User;
use Filament\Notifications\Notification;
use Filament\Notifications\Actions\Action;

class VehicleBookingObserver
{
    /**
     * Handle the VehicleBooking "created" event.
     */
    public function created(VehicleBooking $booking): void
    {
        // Notifikasi ke semua admin bahwa ada peminjaman baru
        $admins = User::role('super_admin')->where('id', '!=', $booking->user_id)->get();

        foreach ($admins as $admin) {
            Notification::make()
                ->title('Peminjaman KDO Baru: ' . $booking->booking_number)
                ->body("{$booking->vehicle->display_name} - {$booking->destination}")
                ->icon('heroicon-o-truck')
                ->iconColor('info')
                ->actions([
                    Action::make('view')
                        ->label('Lihat')
                        ->url(route('filament.admin.resources.vehicle-bookings.view', $booking))
                        ->markAsRead(),
                ])
                ->sendToDatabase($admin);
        }

        // Konfirmasi ke pemohon
        Notification::make()
            ->title('Peminjaman KDO Disetujui')
            ->body("Peminjaman {$booking->booking_number} untuk {$booking->vehicle->display_name} telah disetujui")
            ->icon('heroicon-o-check-circle')
            ->iconColor('success')
            ->actions([
                Action::make('view')
                    ->label('Lihat Detail')
                    ->url(route('filament.admin.resources.vehicle-bookings.view', $booking))
                    ->markAsRead(),
            ])
            ->sendToDatabase($booking->user);
    }

    /**
     * Handle the VehicleBooking "updated" event.
     */
    public function updated(VehicleBooking $booking): void
    {
        // Cek apakah status berubah
        if ($booking->isDirty('status')) {
            $oldStatus = $booking->getOriginal('status');
            $newStatus = $booking->status;

            $statusLabels = [
                'approved' => 'Disetujui',
                'in_use' => 'Sedang Digunakan',
                'completed' => 'Selesai',
                'cancelled' => 'Dibatalkan',
            ];

            $statusColors = [
                'approved' => 'info',
                'in_use' => 'warning',
                'completed' => 'success',
                'cancelled' => 'danger',
            ];

            // Notifikasi ke pemohon jika bukan dia yang mengubah
            if ($booking->user_id !== auth()->id()) {
                $body = "Peminjaman {$booking->booking_number} status berubah menjadi: {$statusLabels[$newStatus]}";

                if ($newStatus === 'cancelled' && $booking->cancellation_reason) {
                    $body .= "\nAlasan: {$booking->cancellation_reason}";
                }

                Notification::make()
                    ->title('Status Peminjaman KDO Diperbarui')
                    ->body($body)
                    ->icon('heroicon-o-arrow-path')
                    ->iconColor($statusColors[$newStatus] ?? 'gray')
                    ->actions([
                        Action::make('view')
                            ->label('Lihat Detail')
                            ->url(route('filament.admin.resources.vehicle-bookings.view', $booking))
                            ->markAsRead(),
                    ])
                    ->sendToDatabase($booking->user);
            }

            // Notifikasi khusus saat selesai dikembalikan
            if ($newStatus === 'completed') {
                $admins = User::role('super_admin')->get();

                foreach ($admins as $admin) {
                    Notification::make()
                        ->title('KDO Telah Dikembalikan')
                        ->body("{$booking->vehicle->display_name} telah dikembalikan oleh {$booking->user->name}")
                        ->icon('heroicon-o-check-badge')
                        ->iconColor('success')
                        ->actions([
                            Action::make('view')
                                ->label('Lihat Detail')
                                ->url(route('filament.admin.resources.vehicle-bookings.view', $booking))
                                ->markAsRead(),
                        ])
                        ->sendToDatabase($admin);
                }
            }
        }
    }

    /**
     * Handle the VehicleBooking "deleted" event.
     */
    public function deleted(VehicleBooking $booking): void
    {
        //
    }

    /**
     * Handle the VehicleBooking "restored" event.
     */
    public function restored(VehicleBooking $booking): void
    {
        //
    }

    /**
     * Handle the VehicleBooking "force deleted" event.
     */
    public function forceDeleted(VehicleBooking $booking): void
    {
        //
    }
}
