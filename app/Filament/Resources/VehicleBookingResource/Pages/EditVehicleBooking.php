<?php

namespace App\Filament\Resources\VehicleBookingResource\Pages;

use App\Filament\Resources\VehicleBookingResource;
use App\Models\VehicleBooking;
use Filament\Actions;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\EditRecord;

class EditVehicleBooking extends EditRecord
{
    protected static string $resource = VehicleBookingResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\ViewAction::make(),
            Actions\DeleteAction::make()
                ->visible(fn () => auth()->user()->hasRole('super_admin')),
        ];
    }

    protected function beforeSave(): void
    {
        // Cek availability kendaraan saat update
        $vehicleId = $this->data['vehicle_id'];
        $startDate = $this->data['start_date'];
        $endDate = $this->data['end_date'];

        if (!VehicleBooking::isVehicleAvailable($vehicleId, $startDate, $endDate, $this->record->id)) {
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
}
