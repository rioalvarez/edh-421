<?php

namespace App\Filament\Widgets;

use App\Models\Vehicle;
use App\Models\VehicleBooking;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class VehicleBookingStats extends BaseWidget
{
    protected static ?string $pollingInterval = '30s';

    protected static ?int $sort = 1;

    protected function getStats(): array
    {
        $isAdmin = auth()->user()->hasRole('super_admin');
        $userId = auth()->id();

        // Query untuk booking aktif
        $activeBookingsQuery = VehicleBooking::whereIn('status', ['approved', 'in_use']);
        if (!$isAdmin) {
            $activeBookingsQuery->where('user_id', $userId);
        }
        $activeBookings = $activeBookingsQuery->count();

        // Query untuk booking perlu dikembalikan
        $needsReturnQuery = VehicleBooking::query()->needsReturn();
        if (!$isAdmin) {
            $needsReturnQuery->where('user_id', $userId);
        }
        $needsReturn = $needsReturnQuery->count();

        // Kendaraan tersedia
        $availableVehicles = Vehicle::available()->count();
        $totalVehicles = Vehicle::active()->count();

        // Booking bulan ini
        $monthlyBookingsQuery = VehicleBooking::whereMonth('created_at', now()->month)
            ->whereYear('created_at', now()->year);
        if (!$isAdmin) {
            $monthlyBookingsQuery->where('user_id', $userId);
        }
        $monthlyBookings = $monthlyBookingsQuery->count();

        $stats = [
            Stat::make('Peminjaman Aktif', $activeBookings)
                ->description($isAdmin ? 'Total peminjaman aktif' : 'Peminjaman aktif Anda')
                ->descriptionIcon('heroicon-m-clipboard-document-check')
                ->color($activeBookings > 0 ? 'warning' : 'success')
                ->chart([7, 3, 4, 5, 6, $activeBookings]),

            Stat::make('Perlu Dikembalikan', $needsReturn)
                ->description('Melewati tanggal selesai')
                ->descriptionIcon('heroicon-m-exclamation-triangle')
                ->color($needsReturn > 0 ? 'danger' : 'success')
                ->chart([2, 1, 3, 2, 1, $needsReturn]),
        ];

        if ($isAdmin) {
            $stats[] = Stat::make('Kendaraan Tersedia', "{$availableVehicles}/{$totalVehicles}")
                ->description('Siap digunakan hari ini')
                ->descriptionIcon('heroicon-m-truck')
                ->color($availableVehicles > 0 ? 'success' : 'danger')
                ->chart([4, 5, 3, 4, 5, $availableVehicles]);
        }

        $stats[] = Stat::make('Peminjaman Bulan Ini', $monthlyBookings)
            ->description(now()->translatedFormat('F Y'))
            ->descriptionIcon('heroicon-m-calendar')
            ->color('info')
            ->chart([3, 5, 4, 6, 5, $monthlyBookings]);

        return $stats;
    }
}
