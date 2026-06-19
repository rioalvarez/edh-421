<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Pages;

use App\Enums\VehicleBookingStatus;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource;
use App\Models\VehicleBooking;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\CreateRecord;

class CreateVehicleBooking extends CreateRecord
{
    protected static string $resource = VehicleBookingResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        // Set user_id ke current user jika bukan admin
        if (auth()->user()?->isItAdmin() !== true) {
            $data['user_id'] = auth()->id();
        }

        // Status otomatis approved
        $data['status'] = VehicleBookingStatus::Approved->value;

        return $data;
    }

    protected function beforeCreate(): void
    {
        // Cek lagi apakah user punya peminjaman yang belum dikembalikan
        $userId = $this->data['user_id'] ?? auth()->id();

        if (VehicleBooking::userHasUnreturnedBooking($userId)) {
            $booking = VehicleBooking::getUserUnreturnedBooking($userId);

            Notification::make()
                ->title('Tidak dapat mengajukan peminjaman')
                ->body("Pemohon masih memiliki peminjaman {$booking->booking_number} yang belum dikembalikan.")
                ->danger()
                ->send();

            $this->halt();
        }

        // Cek availability kendaraan
        $vehicleId = $this->data['vehicle_id'];
        $startDate = $this->data['start_date'];
        $endDate = $this->data['end_date'];

        if (! VehicleBooking::isVehicleAvailable($vehicleId, $startDate, $endDate)) {
            Notification::make()
                ->title('Kendaraan tidak tersedia')
                ->body('Kendaraan sudah dipinjam pada tanggal tersebut. Silakan pilih tanggal lain.')
                ->danger()
                ->send();

            $this->halt();
        }
    }

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }

    protected function getCreatedNotificationTitle(): ?string
    {
        return 'Peminjaman berhasil diajukan dan disetujui';
    }
}
