<?php

namespace App\Filament\Widgets;

use App\Enums\VehicleBookingStatus;
use App\Enums\VehicleStatus;
use App\Filament\Concerns\HasModuleWidgetGate;
use App\Models\Vehicle;
use App\Models\VehicleBooking;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\Cache;

class VehicleBookingStats extends BaseWidget
{
    use HasModuleWidgetGate;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::VEHICLES_BOOKINGS;

    protected static ?string $pollingInterval = '60s';

    protected static ?int $sort = 1;

    // Implement canView method
    public static function canView(): bool
    {
        if (auth()->user()?->hasRole('Member')) {
            return false;
        }

        return static::passesModuleWidgetGate()
            && auth()->user()?->isItAdmin() !== true;
    }

    /**
     * Generate SQL placeholders for an array of values.
     */
    private function placeholders(array $values): string
    {
        return implode(',', array_fill(0, count($values), '?'));
    }

    protected function getStats(): array
    {
        $isAdmin = auth()->user()?->isItAdmin() ?? false;
        $userId = auth()->id();
        $cacheKey = "vehicle_booking_stats_{$userId}_".($isAdmin ? 'admin' : 'user');

        $stats = Cache::remember($cacheKey, now()->addMinute(), function () use ($isAdmin, $userId) {
            $activeValues = VehicleBookingStatus::activeValues();
            $currentMonth = now()->month;
            $currentYear = now()->year;

            // Single aggregated query for booking stats
            $bookingQuery = VehicleBooking::query();
            if (! $isAdmin) {
                $bookingQuery->where('user_id', $userId);
            }

            $row = (clone $bookingQuery)->selectRaw("
                SUM(status IN ({$this->placeholders($activeValues)})) as active_bookings,
                SUM(status IN ({$this->placeholders($activeValues)}) AND end_date < CURDATE() AND returned_at IS NULL) as needs_return,
                SUM(MONTH(created_at) = ? AND YEAR(created_at) = ?) as monthly_bookings
            ", [
                ...$activeValues,
                ...$activeValues,
                $currentMonth,
                $currentYear,
            ])->first();

            $availableVehicles = 0;
            $totalVehicles = 0;

            if ($isAdmin) {
                $vehicleRow = Vehicle::selectRaw('
                    SUM(status = ?) as available_vehicles,
                    SUM(status IN (?, ?)) as total_vehicles
                ', [
                    VehicleStatus::Available->value,
                    VehicleStatus::Available->value,
                    VehicleStatus::InUse->value,
                ])->first();

                $availableVehicles = (int) ($vehicleRow->available_vehicles ?? 0);
                $totalVehicles = (int) ($vehicleRow->total_vehicles ?? 0);
            }

            return [
                'activeBookings' => (int) ($row->active_bookings ?? 0),
                'needsReturn' => (int) ($row->needs_return ?? 0),
                'monthlyBookings' => (int) ($row->monthly_bookings ?? 0),
                'availableVehicles' => $availableVehicles,
                'totalVehicles' => $totalVehicles,
            ];
        });

        $result = [
            Stat::make('Peminjaman Aktif', $stats['activeBookings'])
                ->description($isAdmin ? 'Total peminjaman aktif' : 'Peminjaman aktif Anda')
                ->descriptionIcon('heroicon-m-clipboard-document-check')
                ->color($stats['activeBookings'] > 0 ? 'warning' : 'success')
                ->chart([7, 3, 4, 5, 6, $stats['activeBookings']]),

            Stat::make('Perlu Dikembalikan', $stats['needsReturn'])
                ->description('Melewati tanggal selesai')
                ->descriptionIcon('heroicon-m-exclamation-triangle')
                ->color($stats['needsReturn'] > 0 ? 'danger' : 'success')
                ->chart([2, 1, 3, 2, 1, $stats['needsReturn']]),
        ];

        if ($isAdmin) {
            $result[] = Stat::make('Kendaraan Tersedia', "{$stats['availableVehicles']}/{$stats['totalVehicles']}")
                ->description('Siap digunakan hari ini')
                ->descriptionIcon('heroicon-m-truck')
                ->color($stats['availableVehicles'] > 0 ? 'success' : 'danger')
                ->chart([4, 5, 3, 4, 5, $stats['availableVehicles']]);
        }

        $result[] = Stat::make('Peminjaman Bulan Ini', $stats['monthlyBookings'])
            ->description(now()->translatedFormat('F Y'))
            ->descriptionIcon('heroicon-m-calendar')
            ->color('info')
            ->chart([3, 5, 4, 6, 5, $stats['monthlyBookings']]);

        return $result;
    }
}
