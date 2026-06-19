<?php

namespace App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource\Api\Handlers;

use App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource;
use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;

class DetailHandler extends Handlers
{
    public static ?string $uri = '/{id}';

    public static ?string $resource = ArticleResource::class;

    public static function getMethod()
    {
        return Handlers::GET;
    }

    public static function getModel()
    {
        return static::$resource::getModel();
    }

    public function handler(Request $request)
    {
        $id = $request->route('id');

        $model = static::getModel()::find($id);

        if (! $model) {
            return static::sendNotFoundResponse();
        }

        return static::sendSuccessResponse($model, 'Article retrieved successfully');
    }
}
