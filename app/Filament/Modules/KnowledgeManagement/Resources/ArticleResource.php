<?php

namespace App\Filament\Modules\KnowledgeManagement\Resources;

use App\Filament\Concerns\HasModuleNavigationGate;
use App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource\Infolists\ArticleInfolist;
use App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource\Pages;
use App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource\Schemas\ArticleForm;
use App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource\Tables\ArticleTable;
use App\Models\Article;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;
use Filament\Forms\Form;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class ArticleResource extends Resource implements HasShieldPermissions
{
    use HasModuleNavigationGate;

    protected static ?string $model = Article::class;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::KNOWLEDGE_ARTICLES;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';

    protected static ?string $navigationGroup = 'Knowledge Management';

    protected static ?string $modelLabel = 'Artikel';

    protected static ?string $pluralModelLabel = 'Artikel';

    protected static ?int $navigationSort = 1;

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->with(['author', 'category', 'media']);
    }

    public static function getPermissionPrefixes(): array
    {
        return [
            'view',
            'view_any',
            'create',
            'update',
            'delete',
            'delete_any',
            'article:create',
            'article:update',
            'article:delete',
            'article:pagination',
            'article:detail',
        ];
    }

    public static function form(Form $form): Form
    {
        return ArticleForm::configure($form);
    }

    public static function table(Table $table): Table
    {
        return ArticleTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListArticles::route('/'),
            'create' => Pages\CreateArticle::route('/create'),
            'view' => Pages\ViewArticle::route('/{record}'),
            'edit' => Pages\EditArticle::route('/{record}/edit'),
        ];
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return ArticleInfolist::configure($infolist);
    }
}
