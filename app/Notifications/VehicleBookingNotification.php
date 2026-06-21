<?php

namespace App\Notifications;

use App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource;
use Filament\Notifications\Actions\Action;
use Filament\Notifications\Notification as FilamentNotification;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Notification;

class VehicleBookingNotification extends Notification implements ShouldQueue
{
    use Queueable;

    public function __construct(
        private readonly int $bookingId,
        private readonly string $title,
        private readonly string $body,
        private readonly string $icon,
        private readonly string $iconColor,
    ) {}

    /**
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['database'];
    }

    /**
     * @return array<string, mixed>
     */
    public function toDatabase(object $notifiable): array
    {
        return FilamentNotification::make()
            ->title($this->title)
            ->body($this->body)
            ->icon($this->icon)
            ->iconColor($this->iconColor)
            ->actions([
                Action::make('view')
                    ->label('Lihat Detail')
                    ->url(VehicleBookingResource::getUrl('view', ['record' => $this->bookingId]))
                    ->markAsRead(),
            ])
            ->getDatabaseMessage();
    }

    public static function created(int $bookingId, string $bookingNumber, string $vehicleDisplayName, string $destination): self
    {
        return new self(
            bookingId: $bookingId,
            title: "Peminjaman KDO Baru: {$bookingNumber}",
            body: "{$vehicleDisplayName} - {$destination}",
            icon: 'heroicon-o-truck',
            iconColor: 'info',
        );
    }

    public static function approved(int $bookingId, string $bookingNumber, string $vehicleDisplayName): self
    {
        return new self(
            bookingId: $bookingId,
            title: 'Peminjaman KDO Disetujui',
            body: "Peminjaman {$bookingNumber} untuk {$vehicleDisplayName} telah disetujui",
            icon: 'heroicon-o-check-circle',
            iconColor: 'success',
        );
    }

    public static function statusChanged(int $bookingId, string $bookingNumber, string $statusLabel, string $statusColor, ?string $reason = null): self
    {
        $body = "Peminjaman {$bookingNumber} status berubah menjadi: {$statusLabel}";
        if ($reason) {
            $body .= "\nAlasan: {$reason}";
        }

        return new self(
            bookingId: $bookingId,
            title: 'Status Peminjaman KDO Diperbarui',
            body: $body,
            icon: 'heroicon-o-arrow-path',
            iconColor: $statusColor,
        );
    }

    public static function returned(int $bookingId, string $vehicleDisplayName, string $userName): self
    {
        return new self(
            bookingId: $bookingId,
            title: 'KDO Telah Dikembalikan',
            body: "{$vehicleDisplayName} telah dikembalikan oleh {$userName}",
            icon: 'heroicon-o-check-badge',
            iconColor: 'success',
        );
    }
}
