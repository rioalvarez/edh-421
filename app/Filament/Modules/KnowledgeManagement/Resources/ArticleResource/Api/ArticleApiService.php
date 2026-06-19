<?php

namespace App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource\Api;

use App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource;
use Rupadana\ApiService\ApiService;

class ArticleApiService extends ApiService
{
    protected static ?string $resource = ArticleResource::class;

    public static function handlers(): array
    {
        return [
            Handlers\CreateHandler::class,
            Handlers\UpdateHandler::class,
            Handlers\DeleteHandler::class,
            Handlers\PaginationHandler::class,
            Handlers\DetailHandler::class,
        ];
    }
}
