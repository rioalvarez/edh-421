<?php

namespace App\Filament\Resources\DeviceAttributeResource\Pages;

use App\Filament\Resources\DeviceAttributeResource;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;

class ViewDeviceAttribute extends ViewRecord
{
    protected static string $resource = DeviceAttributeResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\EditAction::make(),
        ];
    }
}
