<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceAttributeResource\Pages;

use App\Filament\Modules\Inventaris\Resources\DeviceAttributeResource;
use Filament\Resources\Pages\CreateRecord;

class CreateDeviceAttribute extends CreateRecord
{
    protected static string $resource = DeviceAttributeResource::class;

    protected static bool $canCreateAnother = false;

    public function getTitle(): string
    {
        return 'Rekam Data Atribut';
    }

    // customize redirect after create
    public function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
