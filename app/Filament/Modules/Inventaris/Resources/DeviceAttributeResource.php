<?php

namespace App\Filament\Modules\Inventaris\Resources;

use App\Filament\Concerns\HasModuleNavigationGate;
use App\Filament\Modules\Inventaris\Resources\DeviceAttributeResource\Infolists\DeviceAttributeInfolist;
use App\Filament\Modules\Inventaris\Resources\DeviceAttributeResource\Pages;
use App\Filament\Modules\Inventaris\Resources\DeviceAttributeResource\Schemas\DeviceAttributeForm;
use App\Filament\Modules\Inventaris\Resources\DeviceAttributeResource\Tables\DeviceAttributeTable;
use App\Models\DeviceAttribute;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;
use Filament\Forms\Form;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables\Table;

class DeviceAttributeResource extends Resource implements HasShieldPermissions
{
    use HasModuleNavigationGate;

    protected static ?string $model = DeviceAttribute::class;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::INVENTORY_ATTRIBUTES;

    protected static ?string $navigationIcon = 'heroicon-o-adjustments-horizontal';

    protected static ?string $navigationGroup = 'Inventaris';

    protected static ?int $navigationSort = 2;

    protected static ?string $navigationLabel = 'Setting Informasi Perangkat';

    protected static ?string $modelLabel = 'Setting Informasi Perangkat';

    protected static ?string $pluralModelLabel = 'Setting Informasi Perangkat';

    public static function getPermissionPrefixes(): array
    {
        return [
            'view',
            'view_any',
            'create',
            'update',
            'delete',
            'delete_any',
            'reorder',
        ];
    }

    public static function form(Form $form): Form
    {
        return DeviceAttributeForm::configure($form);
    }

    public static function table(Table $table): Table
    {
        return DeviceAttributeTable::configure($table);
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return DeviceAttributeInfolist::configure($infolist);
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
            'index' => Pages\ListDeviceAttributes::route('/'),
            'create' => Pages\CreateDeviceAttribute::route('/create'),
            'view' => Pages\ViewDeviceAttribute::route('/{record}'),
            'edit' => Pages\EditDeviceAttribute::route('/{record}/edit'),
        ];
    }
}
