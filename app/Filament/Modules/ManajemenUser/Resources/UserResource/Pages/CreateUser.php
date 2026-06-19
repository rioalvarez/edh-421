<?php

namespace App\Filament\Modules\ManajemenUser\Resources\UserResource\Pages;

use App\Filament\Modules\ManajemenUser\Resources\UserResource;
use Filament\Resources\Pages\CreateRecord;

class CreateUser extends CreateRecord
{
    protected static string $resource = UserResource::class;

    protected static bool $canCreateAnother = false;

    // customize redirect after create
    public function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
