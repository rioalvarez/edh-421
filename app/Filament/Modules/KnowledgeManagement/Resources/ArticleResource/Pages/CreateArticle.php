<?php

namespace App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource\Pages;

use App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource;
use Filament\Resources\Pages\CreateRecord;

class CreateArticle extends CreateRecord
{
    protected static string $resource = ArticleResource::class;

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
