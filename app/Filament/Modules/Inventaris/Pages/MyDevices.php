<?php

namespace App\Filament\Modules\Inventaris\Pages;

use App\Filament\Concerns\HasModuleNavigationGate;
use App\Models\Device;
use Filament\Pages\Page;
use Illuminate\Database\Eloquent\Collection;

class MyDevices extends Page
{
    use HasModuleNavigationGate;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::INVENTORY_DEVICES;

    protected static ?string $navigationIcon = 'heroicon-o-cpu-chip';

    protected static ?string $navigationGroup = 'Inventaris';

    protected static ?int $navigationSort = 4;

    protected static ?string $navigationLabel = 'Perangkat Saya';

    protected static ?string $title = 'Perangkat Saya';

    protected static string $view = 'filament.pages.my-devices';

    /**
     * Tampil untuk semua user yang login selama modul Inventaris aktif.
     * Sengaja tanpa HasPageShield agar member bisa melihat perangkatnya sendiri.
     */
    /**
     * Perangkat yang di-assign ke user yang sedang login.
     */
    public function getDevices(): Collection
    {
        return Device::query()
            ->with(['unit', 'attributeValues.attribute'])
            ->where('user_id', auth()->id())
            ->orderBy('type')
            ->orderBy('hostname')
            ->get();
    }
}
