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

        // Perangkat tanpa IP Address
        $noIpAddress = Device::whereNull('ip_address')
            ->where('status', '!=', 'retired')
            ->count();

        return [
            Stat::make('Total Perangkat', $totalDevices)
                ->description('Semua perangkat komputer')
                ->descriptionIcon('heroicon-m-computer-desktop')
                ->color('primary')
                ->chart([7, 5, 8, 6, 9, $totalDevices]),

            Stat::make('Perangkat Aktif', $activeDevices)
                ->description("{$unassignedDevices} belum di-assign")
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

            Stat::make('Belum Ada IP', $noIpAddress)
                ->description('Perangkat tanpa IP Address')
                ->descriptionIcon('heroicon-m-signal-slash')
                ->color($noIpAddress > 0 ? 'danger' : 'success')
                ->chart([3, 4, 5, 4, 6, $noIpAddress]),

            Stat::make('Non-Aktif/Retired', $retiredDevices)
                ->description('Perangkat tidak digunakan')
                ->descriptionIcon('heroicon-m-archive-box')
                ->color('gray')
                ->chart([1, 1, 2, 1, 1, $retiredDevices]),
        ];
    }
}
