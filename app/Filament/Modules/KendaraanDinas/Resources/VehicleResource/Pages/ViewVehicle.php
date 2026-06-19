<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleResource\Pages;

use App\Filament\Modules\KendaraanDinas\Resources\VehicleResource;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;

class ViewVehicle extends ViewRecord
{
    protected static string $resource = VehicleResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\EditAction::make(),
        ];
    }
}
