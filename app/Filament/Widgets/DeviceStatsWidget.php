<?php

namespace App\Filament\Widgets;

use App\Models\Device;
use Filament\Widgets\Widget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class DeviceStatsWidget extends Widget
{
    protected static string $view = 'filament.widgets.device-stats-widget';

    protected static ?string $pollingInterval = '60s';

    protected static ?int $sort = 4;

    protected int | string | array $columnSpan = 'full';

    public static function canView(): bool
    {
        return auth()->user()->hasRole('super_admin');
    }

    public function getStats(): array
    {
        $totalDevices = Device::count();
        $activeDevices = Device::where('status', 'active')->count();
        $maintenanceDevices = Device::where('status', 'maintenance')->count();
        $retiredDevices = Device::where('status', 'retired')->count();

        // Perangkat dengan kondisi buruk
        $poorConditionDevices = Device::whereIn('condition', ['poor', 'broken'])->count();

        // Perangkat yang belum ditugaskan
        $unassignedDevices = Device::whereNull('user_id')
            ->where('status', 'active')
            ->count();

        // Garansi akan habis dalam 30 hari
        $warrantyExpiringSoon = Device::whereNotNull('warranty_expiry')
            ->where('warranty_expiry', '>', now())
            ->where('warranty_expiry', '<=', now()->addDays(30))
            ->count();

        // Garansi sudah habis
        $warrantyExpired = Device::whereNotNull('warranty_expiry')
            ->where('warranty_expiry', '<', now())
            ->count();

        return [
            Stat::make('Total Perangkat', $totalDevices)
                ->description('Semua perangkat komputer')
                ->descriptionIcon('heroicon-m-computer-desktop')
                ->color('primary')
                ->chart([7, 5, 8, 6, 9, $totalDevices]),

            Stat::make('Perangkat Aktif', $activeDevices)
                ->description("{$unassignedDevices} belum ditugaskan")
                ->descriptionIcon('heroicon-m-check-circle')
                ->color('success')
                ->chart([4, 5, 6, 5, 7, $activeDevices]),

            Stat::make('Dalam Perbaikan', $maintenanceDevices)
                ->description('Sedang maintenance')
                ->descriptionIcon('heroicon-m-wrench-screwdriver')
                ->color($maintenanceDevices > 0 ? 'warning' : 'success')
                ->chart([2, 3, 2, 4, 3, $maintenanceDevices]),

            Stat::make('Kondisi Buruk', $poorConditionDevices)
                ->description('Perlu perhatian')
                ->descriptionIcon('heroicon-m-exclamation-triangle')
                ->color($poorConditionDevices > 0 ? 'danger' : 'success')
                ->chart([1, 2, 1, 3, 2, $poorConditionDevices]),

            Stat::make('Garansi Habis', "{$warrantyExpired}")
                ->description("{$warrantyExpiringSoon} akan habis 30 hari")
                ->descriptionIcon('heroicon-m-shield-exclamation')
                ->color($warrantyExpired > 5 ? 'danger' : ($warrantyExpired > 0 ? 'warning' : 'success'))
                ->chart([3, 4, 5, 4, 6, $warrantyExpired]),

            Stat::make('Non-Aktif/Retired', $retiredDevices)
                ->description('Perangkat tidak digunakan')
                ->descriptionIcon('heroicon-m-archive-box')
                ->color('gray')
                ->chart([1, 1, 2, 1, 1, $retiredDevices]),
        ];
    }
}
