<?php

namespace App\Filament\Resources\VehicleBookingResource\Pages;

use App\Filament\Resources\VehicleBookingResource;
use App\Models\VehicleBooking;
use Filament\Actions;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\ListRecords;

class ListVehicleBookings extends ListRecords
{
    protected static string $resource = VehicleBookingResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make()
                ->label('Ajukan Peminjaman')
                ->before(function (Actions\CreateAction $action) {
                    // Cek apakah user punya peminjaman yang belum dikembalikan
                    if (VehicleBooking::userHasUnreturnedBooking(auth()->id())) {
                        $booking = VehicleBooking::getUserUnreturnedBooking(auth()->id());

                        Notification::make()
                            ->title('Tidak dapat mengajukan peminjaman')
                            ->body("Anda masih memiliki peminjaman {$booking->booking_number} yang belum dikembalikan.")
                            ->danger()
                            ->send();

                        $action->halt();
                    }
                }),
        ];
    }
}
