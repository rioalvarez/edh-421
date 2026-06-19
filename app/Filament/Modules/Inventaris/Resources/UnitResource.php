<?php

namespace App\Filament\Modules\Inventaris\Resources;

use App\Filament\Concerns\HasModuleNavigationGate;
use App\Filament\Modules\Inventaris\Resources\UnitResource\Pages;
use App\Filament\Modules\Inventaris\Resources\UnitResource\Schemas\UnitForm;
use App\Filament\Modules\Inventaris\Resources\UnitResource\Tables\UnitTable;
use App\Models\Unit;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables\Table;

class UnitResource extends Resource implements HasShieldPermissions
{
    use HasModuleNavigationGate;

    protected static ?string $model = Unit::class;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::INVENTORY_UNITS;

    protected static ?string $navigationIcon = 'heroicon-o-building-office-2';

    protected static ?string $navigationGroup = 'Inventaris';

    protected static ?int $navigationSort = 3;

    protected static ?string $navigationLabel = 'Unit Penanggung Jawab';

    protected static ?string $modelLabel = 'Unit';

    protected static ?string $pluralModelLabel = 'Unit';

    public static function getPermissionPrefixes(): array
    {
        return [
            'view',
            'view_any',
            'create',
            'update',
            'delete',
            'delete_any',
        ];
    }

    public static function form(Form $form): Form
    {
        return UnitForm::configure($form);
    }

    public static function table(Table $table): Table
    {
        return UnitTable::configure($table);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListUnits::route('/'),
            'create' => Pages\CreateUnit::route('/create'),
            'edit' => Pages\EditUnit::route('/{record}/edit'),
        ];
    }
}
