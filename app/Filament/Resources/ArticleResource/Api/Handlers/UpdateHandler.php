<?php

namespace App\Filament\Resources\ArticleResource\Api\Handlers;

use App\Filament\Resources\ArticleResource;
use Rupadana\ApiService\Http\Handlers;
use Illuminate\Http\Request;

class UpdateHandler extends Handlers
{
    public static ?string $uri = '/{id}';
    public static ?string $resource = ArticleResource::class;

    public static function getMethod()
    {
        return Handlers::PUT;
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

        $model->fill($request->all());

        $model->save();

        return static::sendSuccessResponse($model, 'Article updated successfully');
    }
}
