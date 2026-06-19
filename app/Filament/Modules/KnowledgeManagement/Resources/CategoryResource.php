<?php

namespace App\Filament\Modules\KnowledgeManagement\Resources;

use App\Filament\Concerns\HasModuleNavigationGate;
use App\Filament\Modules\KnowledgeManagement\Resources\CategoryResource\Pages;
use App\Filament\Modules\KnowledgeManagement\Resources\CategoryResource\Schemas\CategoryForm;
use App\Filament\Modules\KnowledgeManagement\Resources\CategoryResource\Tables\CategoryTable;
use App\Models\Category;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables\Table;

class CategoryResource extends Resource
{
    use HasModuleNavigationGate;

    protected static ?string $model = Category::class;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::KNOWLEDGE_CATEGORIES;

    protected static ?string $navigationIcon = 'heroicon-o-tag';

    protected static ?string $navigationGroup = 'Knowledge Management';

    protected static ?int $navigationSort = 2;

    protected static ?string $modelLabel = 'Kategori';

    protected static ?string $pluralModelLabel = 'Kategori';

    public static function form(Form $form): Form
    {
        return CategoryForm::configure($form);
    }

    public static function table(Table $table): Table
    {
        return CategoryTable::configure($table);
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
            'index' => Pages\ListCategories::route('/'),
            'create' => Pages\CreateCategory::route('/create'),
            'edit' => Pages\EditCategory::route('/{record}/edit'),
        ];
    }
}
