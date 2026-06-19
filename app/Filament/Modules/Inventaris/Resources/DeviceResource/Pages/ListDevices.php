<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceResource\Pages;

use App\Filament\Modules\Inventaris\Resources\DeviceResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;
use Filament\Support\Enums\MaxWidth;

class ListDevices extends ListRecords
{
    protected static string $resource = DeviceResource::class;

    // Custom view: 2 tab (Statistik Perangkat + Daftar Perangkat)
    protected static string $view = 'filament.resources.device-resource.pages.list-devices';

    public function getMaxContentWidth(): MaxWidth
    {
        return MaxWidth::Full;
    }

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make()
                ->label('Rekam Data Perangkat'),
        ];
    }
}
