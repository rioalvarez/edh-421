<?php

namespace App\Filament\Widgets;

use App\Enums\DeviceCondition;
use App\Enums\DeviceStatus;
use App\Filament\Concerns\HasModuleWidgetGate;
use App\Models\Device;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Filament\Widgets\Widget;
use Illuminate\Support\Facades\Cache;

class DeviceStatsWidget extends Widget
{
    use HasModuleWidgetGate;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::INVENTORY_DEVICES;

    protected static string $view = 'filament.widgets.device-stats-widget';

    protected static ?string $pollingInterval = '120s';

    protected static bool $isLazy = true;

    protected static ?int $sort = 4;

    protected int|string|array $columnSpan = 'full';

    public static function canView(): bool
    {
        if (! static::passesModuleWidgetGate()) {
            return false;
        }

        // Tidak lagi tampil di dashboard — dipindah ke tab "Statistik Perangkat"
        // pada halaman Daftar Perangkat (di-embed langsung via @livewire).
        return false;
    }

    public function getStats(): array
    {
        $stats = Cache::remember('device_stats_widget', now()->addMinutes(2), function () {
            $baseQuery = Device::query();

            return [
                'totalDevices' => (clone $baseQuery)->count(),
                'activeDevices' => (clone $baseQuery)->where('status', DeviceStatus::Active->value)->count(),
                'maintenanceDevices' => (clone $baseQuery)->where('status', DeviceStatus::Maintenance->value)->count(),
                'retiredDevices' => (clone $baseQuery)->where('status', DeviceStatus::Retired->value)->count(),
                'poorConditionDevices' => (clone $baseQuery)->whereIn('condition', DeviceCondition::poorValues())->count(),
                'unassignedDevices' => (clone $baseQuery)->whereNull('user_id')->where('status', DeviceStatus::Active->value)->count(),
                'noIpAddress' => (clone $baseQuery)->whereNull('ip_address')->where('status', '!=', DeviceStatus::Retired->value)->count(),
            ];
        });

        return [
            Stat::make('Total Perangkat', $stats['totalDevices'])
                ->description('Semua perangkat komputer')
                ->descriptionIcon('heroicon-m-computer-desktop')
                ->color('primary')
                ->chart([7, 5, 8, 6, 9, $stats['totalDevices']]),

            Stat::make('Perangkat Aktif', $stats['activeDevices'])
                ->description("{$stats['unassignedDevices']} belum di-assign")
                ->descriptionIcon('heroicon-m-check-circle')
                ->color('success')
                ->chart([4, 5, 6, 5, 7, $stats['activeDevices']]),

            Stat::make('Dalam Perbaikan', $stats['maintenanceDevices'])
                ->description('Sedang maintenance')
                ->descriptionIcon('heroicon-m-wrench-screwdriver')
                ->color($stats['maintenanceDevices'] > 0 ? 'warning' : 'success')
                ->chart([2, 3, 2, 4, 3, $stats['maintenanceDevices']]),

            Stat::make('Kondisi Buruk', $stats['poorConditionDevices'])
                ->description('Perlu perhatian')
                ->descriptionIcon('heroicon-m-exclamation-triangle')
                ->color($stats['poorConditionDevices'] > 0 ? 'danger' : 'success')
                ->chart([1, 2, 1, 3, 2, $stats['poorConditionDevices']]),

            Stat::make('Belum Ada IP', $stats['noIpAddress'])
                ->description('Perangkat tanpa IP Address')
                ->descriptionIcon('heroicon-m-signal-slash')
                ->color($stats['noIpAddress'] > 0 ? 'danger' : 'success')
                ->chart([3, 4, 5, 4, 6, $stats['noIpAddress']]),

            Stat::make('Non-Aktif/Retired', $stats['retiredDevices'])
                ->description('Perangkat tidak digunakan')
                ->descriptionIcon('heroicon-m-archive-box')
                ->color('gray')
                ->chart([1, 1, 2, 1, 1, $stats['retiredDevices']]),
        ];
    }
}
