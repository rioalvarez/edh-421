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

    /**
     * Generate SQL placeholders for an array of values.
     */
    private function placeholders(array $values): string
    {
        return implode(',', array_fill(0, count($values), '?'));
    }

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
            // Single aggregated query instead of 7 separate COUNT queries
            $row = Device::selectRaw("
                COUNT(*) as total_devices,
                SUM(status = ?) as active_devices,
                SUM(status = ?) as maintenance_devices,
                SUM(status = ?) as retired_devices,
                SUM(`condition` IN ({$this->placeholders(DeviceCondition::poorValues())})) as poor_condition_devices,
                SUM(user_id IS NULL AND status = ?) as unassigned_devices,
                SUM(ip_address IS NULL AND status != ?) as no_ip_address
            ", [
                DeviceStatus::Active->value,
                DeviceStatus::Maintenance->value,
                DeviceStatus::Retired->value,
                ...DeviceCondition::poorValues(),
                DeviceStatus::Active->value,
                DeviceStatus::Retired->value,
            ])->first();

            return [
                'totalDevices' => (int) ($row->total_devices ?? 0),
                'activeDevices' => (int) ($row->active_devices ?? 0),
                'maintenanceDevices' => (int) ($row->maintenance_devices ?? 0),
                'retiredDevices' => (int) ($row->retired_devices ?? 0),
                'poorConditionDevices' => (int) ($row->poor_condition_devices ?? 0),
                'unassignedDevices' => (int) ($row->unassigned_devices ?? 0),
                'noIpAddress' => (int) ($row->no_ip_address ?? 0),
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
