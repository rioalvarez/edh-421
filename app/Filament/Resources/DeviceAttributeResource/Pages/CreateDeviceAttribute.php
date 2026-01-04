<?php

namespace App\Filament\Resources\DeviceAttributeResource\Pages;

use App\Filament\Resources\DeviceAttributeResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateDeviceAttribute extends CreateRecord
{
    protected static string $resource = DeviceAttributeResource::class;
    protected static bool $canCreateAnother = false;

    //customize redirect after create
    public function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
