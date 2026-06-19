<?php

namespace App\Filament\Modules\ManajemenUser\Resources\RoleResource\Pages;

use App\Filament\Modules\ManajemenUser\Resources\RoleResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListRoles extends ListRecords
{
    protected static string $resource = RoleResource::class;

    protected function getActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
