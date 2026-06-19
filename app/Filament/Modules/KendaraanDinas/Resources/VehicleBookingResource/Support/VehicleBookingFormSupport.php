<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Support;

use App\Enums\VehicleBookingStatus;
use App\Models\User;
use App\Models\Vehicle;
use App\Models\VehicleBooking;
use Illuminate\Support\Carbon;
use Illuminate\Support\HtmlString;

class VehicleBookingFormSupport
{
    public static function vehicleOptions(): array
    {
        return Vehicle::active()
            ->orderBy('plate_number')
            ->get(['id', 'plate_number', 'brand', 'model', 'capacity'])
            ->mapWithKeys(fn (Vehicle $vehicle) => [
                $vehicle->id => "{$vehicle->plate_number} - {$vehicle->brand} {$vehicle->model} ({$vehicle->capacity} org)",
            ])
            ->all();
    }

    public static function availabilityStatus(?int $vehicleId, ?string $startDate, ?string $endDate, ?int $recordId = null): HtmlString
    {
        if (! $vehicleId || ! $startDate || ! $endDate) {
            return new HtmlString(
                '<div class="flex items-center gap-2 text-gray-500">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span>Pilih kendaraan dan tanggal untuk cek ketersediaan</span>
                </div>'
            );
        }

        $vehicle = Vehicle::find($vehicleId);

        if (! $vehicle) {
            return self::unavailable('Kendaraan tidak ditemukan');
        }

        if (VehicleBooking::isVehicleAvailable($vehicleId, $startDate, $endDate, $recordId)) {
            $startFormatted = Carbon::parse($startDate)->translatedFormat('d M Y');
            $endFormatted = Carbon::parse($endDate)->translatedFormat('d M Y');

            return new HtmlString(
                '<div class="flex items-center gap-2 text-success-600 dark:text-success-400 font-medium">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span>Tersedia! '.$vehicle->plate_number.' dapat dipinjam pada '.$startFormatted.' - '.$endFormatted.'</span>
                </div>'
            );
        }

        $conflict = VehicleBooking::where('vehicle_id', $vehicleId)
            ->whereIn('status', VehicleBookingStatus::activeValues())
            ->where(function ($query) use ($startDate, $endDate) {
                $query->whereBetween('start_date', [$startDate, $endDate])
                    ->orWhereBetween('end_date', [$startDate, $endDate])
                    ->orWhere(function ($nestedQuery) use ($startDate, $endDate) {
                        $nestedQuery->where('start_date', '<=', $startDate)
                            ->where('end_date', '>=', $endDate);
                    });
            })
            ->when($recordId, fn ($query) => $query->where('id', '!=', $recordId))
            ->with('user:id,name')
            ->first();

        if ($conflict) {
            $conflictUser = $conflict->user;
            $conflictUserName = $conflictUser instanceof User ? $conflictUser->name : 'User tidak diketahui';
            $message = "Sudah dibooking oleh {$conflictUserName} ({$conflict->start_date->format('d M')} - {$conflict->end_date->format('d M')})";
        } else {
            $message = 'Kendaraan tidak tersedia pada tanggal tersebut';
        }

        return self::unavailable($message);
    }

    private static function unavailable(string $message): HtmlString
    {
        return new HtmlString(
            '<div class="flex items-center gap-2 text-danger-600 dark:text-danger-400 font-medium">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                <span>'.$message.'</span>
            </div>'
        );
    }
}
