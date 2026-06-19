<?php

namespace App\Observers;

use App\Enums\VehicleBookingStatus;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource;
use App\Models\User;
use App\Models\VehicleBooking;
use Filament\Notifications\Actions\Action;
use Filament\Notifications\Notification;

class VehicleBookingObserver
{
    /**
     * Handle the VehicleBooking "created" event.
     */
    public function created(VehicleBooking $booking): void
    {
        VehicleBookingResource::clearNavigationCache($booking);

        // Notifikasi ke semua admin bahwa ada peminjaman baru
        $admins = User::itAdmins()->where('id', '!=', $booking->user_id)->get();

        foreach ($admins as $admin) {
            Notification::make()
                ->title('Peminjaman KDO Baru: '.$booking->booking_number)
                ->body("{$booking->vehicle->display_name} - {$booking->destination}")
                ->icon('heroicon-o-truck')
                ->iconColor('info')
                ->actions([
                    Action::make('view')
                        ->label('Lihat')
                        ->url(VehicleBookingResource::getUrl('view', ['record' => $booking]))
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
                    ->url(VehicleBookingResource::getUrl('view', ['record' => $booking]))
                    ->markAsRead(),
            ])
            ->sendToDatabase($booking->user);
    }

    /**
     * Handle the VehicleBooking "updated" event.
     */
    public function updated(VehicleBooking $booking): void
    {
        VehicleBookingResource::clearNavigationCache($booking);

        // Cek apakah status berubah
        if ($booking->isDirty('status')) {
            $newStatus = $booking->status;

            $newStatusLabel = VehicleBookingStatus::tryLabel($newStatus) ?? $newStatus;

            // Notifikasi ke pemohon jika bukan dia yang mengubah
            if ($booking->user_id !== auth()->id()) {
                $body = "Peminjaman {$booking->booking_number} status berubah menjadi: {$newStatusLabel}";

                if ($newStatus === VehicleBookingStatus::Cancelled->value && $booking->cancellation_reason) {
                    $body .= "\nAlasan: {$booking->cancellation_reason}";
                }

                Notification::make()
                    ->title('Status Peminjaman KDO Diperbarui')
                    ->body($body)
                    ->icon('heroicon-o-arrow-path')
                    ->iconColor(VehicleBookingStatus::tryColor($newStatus))
                    ->actions([
                        Action::make('view')
                            ->label('Lihat Detail')
                            ->url(VehicleBookingResource::getUrl('view', ['record' => $booking]))
                            ->markAsRead(),
                    ])
                    ->sendToDatabase($booking->user);
            }

            // Notifikasi khusus saat selesai dikembalikan
            if ($newStatus === VehicleBookingStatus::Completed->value) {
                $admins = User::itAdmins()->get();

                foreach ($admins as $admin) {
                    Notification::make()
                        ->title('KDO Telah Dikembalikan')
                        ->body("{$booking->vehicle->display_name} telah dikembalikan oleh {$booking->user->name}")
                        ->icon('heroicon-o-check-badge')
                        ->iconColor('success')
                        ->actions([
                            Action::make('view')
                                ->label('Lihat Detail')
                                ->url(VehicleBookingResource::getUrl('view', ['record' => $booking]))
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
        VehicleBookingResource::clearNavigationCache($booking);
    }

    /**
     * Handle the VehicleBooking "restored" event.
     */
    public function restored(VehicleBooking $booking): void
    {
        VehicleBookingResource::clearNavigationCache($booking);
    }

    /**
     * Handle the VehicleBooking "force deleted" event.
     */
    public function forceDeleted(VehicleBooking $booking): void
    {
        VehicleBookingResource::clearNavigationCache($booking);
    }
}
