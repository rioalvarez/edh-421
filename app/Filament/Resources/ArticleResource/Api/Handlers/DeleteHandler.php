<?php

namespace App\Filament\Resources\ArticleResource\Api\Handlers;

use App\Filament\Resources\ArticleResource;
use Rupadana\ApiService\Http\Handlers;
use Illuminate\Http\Request;

class DeleteHandler extends Handlers
{
    public static ?string $uri = '/{id}';
    public static ?string $resource = ArticleResource::class;

    public static function getMethod()
    {
        return Handlers::DELETE;
    }

    public static function getModel()
    {
        return static::$resource::getModel();
    }

    public function handler(Request $request)
    {
        $id = $request->route('id');

        $model = static::getModel()::find($id);

        if (!$model) {
            return static::sendNotFoundResponse();
        }

        $model->delete();

        return static::sendSuccessResponse($model, 'Article deleted successfully');
    }
}
