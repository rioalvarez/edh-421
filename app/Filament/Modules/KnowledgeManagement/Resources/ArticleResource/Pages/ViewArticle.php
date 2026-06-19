<?php

namespace App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource\Pages;

use App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;

class ViewArticle extends ViewRecord
{
    protected static string $resource = ArticleResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\Action::make('back')
                ->label('Kembali ke Daftar')
                ->icon('heroicon-o-arrow-left')
                ->color('gray')
                ->url(ArticleResource::getUrl('index')),
            Actions\EditAction::make(),
        ];
    }
}
