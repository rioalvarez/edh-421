<?php

namespace App\Filament\Resources\ArticleResource\Api\Handlers;

use App\Filament\Resources\ArticleResource;
use Rupadana\ApiService\Http\Handlers;
use Illuminate\Http\Request;

class CreateHandler extends Handlers
{
    public static ?string $uri = '/';
    public static ?string $resource = ArticleResource::class;

    public static function getMethod()
    {
        return Handlers::POST;
    }

    public static function getModel()
    {
        return static::$resource::getModel();
    }

    public function handler(Request $request)
    {
        $model = new (static::getModel());

        $model->fill($request->all());

        $model->save();

        return static::sendSuccessResponse($model, 'Article created successfully');
    }
}
