<?php

namespace App\Filament\Modules\KnowledgeManagement\Resources\CategoryResource\Pages;

use App\Filament\Modules\KnowledgeManagement\Resources\CategoryResource;
use Filament\Resources\Pages\EditRecord;

class EditCategory extends EditRecord
{
    protected static string $resource = CategoryResource::class;

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
