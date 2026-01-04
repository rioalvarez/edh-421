<?php

namespace App\Filament\Imports;

use App\Models\Article;
use Filament\Actions\Imports\ImportColumn;
use Filament\Actions\Imports\Importer;
use Filament\Actions\Imports\Models\Import;
use Illuminate\Support\Str;

class ArticleImporter extends Importer
{
    protected static ?string $model = Article::class;

    public static function getColumns(): array
    {
        return [
            ImportColumn::make('title')
                ->requiredMapping()
                ->rules(['required', 'max:255']),
            ImportColumn::make('slug')
                ->rules(['max:255']),
            ImportColumn::make('author_name')
                ->label('Author')
                ->requiredMapping()
                ->rules(['required', 'max:255']),
            ImportColumn::make('category')
                ->rules(['in:tutorial,tips-tricks,news,review,troubleshooting,security,other']),
            ImportColumn::make('status')
                ->rules(['in:draft,published,archived']),
            ImportColumn::make('content')
                ->requiredMapping()
                ->rules(['required']),
            ImportColumn::make('published_at')
                ->rules(['nullable', 'date']),
        ];
    }

    public function resolveRecord(): ?Article
    {
        $article = new Article();

        // Auto-generate slug if not provided
        if (empty($this->data['slug'])) {
            $article->slug = Str::slug($this->data['title']);
        }

        // Set default status if not provided
        if (empty($this->data['status'])) {
            $article->status = 'draft';
        }

        // Set default category if not provided
        if (empty($this->data['category'])) {
            $article->category = 'other';
        }

        return $article;
    }

    public static function getCompletedNotificationBody(Import $import): string
    {
        $body = 'Your article import has completed and ' . number_format($import->successful_rows) . ' ' . str('row')->plural($import->successful_rows) . ' imported.';

        if ($failedRowsCount = $import->getFailedRowsCount()) {
            $body .= ' ' . number_format($failedRowsCount) . ' ' . str('row')->plural($failedRowsCount) . ' failed to import.';
        }

        return $body;
    }
}
