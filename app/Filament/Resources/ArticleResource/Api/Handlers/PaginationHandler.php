<?php

namespace App\Filament\Resources\ArticleResource\Api\Handlers;

use App\Filament\Resources\ArticleResource;
use Rupadana\ApiService\Http\Handlers;
use Spatie\QueryBuilder\QueryBuilder;
use Illuminate\Http\Request;

class PaginationHandler extends Handlers
{
    public static ?string $uri = '/';
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
        $query = static::getModel()::query();

        $query = QueryBuilder::for($query)
            ->allowedFilters(['title', 'author_name', 'category', 'status'])
            ->allowedSorts(['title', 'created_at', 'published_at', 'views'])
            ->paginate($request->input('per_page', 15))
            ->appends($request->query());

        return static::sendSuccessResponse($query, 'Articles retrieved successfully');
    }
}
