<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleResource\Pages;

use App\Filament\Modules\KendaraanDinas\Resources\VehicleResource;
use Filament\Resources\Pages\CreateRecord;

class CreateVehicle extends CreateRecord
{
    protected static string $resource = VehicleResource::class;

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
