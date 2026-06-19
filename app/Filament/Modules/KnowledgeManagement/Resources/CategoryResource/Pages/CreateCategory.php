<?php

namespace App\Filament\Modules\KnowledgeManagement\Resources\CategoryResource\Pages;

use App\Filament\Modules\KnowledgeManagement\Resources\CategoryResource;
use Filament\Resources\Pages\CreateRecord;

class CreateCategory extends CreateRecord
{
    protected static string $resource = CategoryResource::class;

    protected static bool $canCreateAnother = false;

    // customize redirect after create
    public function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
