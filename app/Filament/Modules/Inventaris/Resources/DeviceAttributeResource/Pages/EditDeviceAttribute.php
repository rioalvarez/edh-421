<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceAttributeResource\Pages;

use App\Filament\Modules\Inventaris\Resources\DeviceAttributeResource;
use Filament\Resources\Pages\EditRecord;

class EditDeviceAttribute extends EditRecord
{
    protected static string $resource = DeviceAttributeResource::class;

    protected function getHeaderActions(): array
    {
        return [
        ];
    }

    // customize redirect after create
    public function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
