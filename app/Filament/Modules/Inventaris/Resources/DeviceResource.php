<?php

namespace App\Filament\Modules\Inventaris\Resources;

use App\Filament\Concerns\HasModuleNavigationGate;
use App\Filament\Modules\Inventaris\Resources\DeviceResource\Pages;
use App\Filament\Modules\Inventaris\Resources\DeviceResource\RelationManagers;
use App\Models\Device;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;
use Filament\Forms\Form;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class DeviceResource extends Resource implements HasShieldPermissions
{
    use HasModuleNavigationGate;

    protected static ?string $model = Device::class;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::INVENTORY_DEVICES;

    protected static ?string $navigationIcon = 'heroicon-o-computer-desktop';

    protected static ?string $navigationGroup = 'Inventaris';

    protected static ?int $navigationSort = 1;

    protected static ?string $navigationLabel = 'Daftar Perangkat';

    protected static ?string $modelLabel = 'Device';

    protected static ?string $pluralModelLabel = 'Device';

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

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->with(['user', 'unit']); // Eager loading untuk performa
    }

    public static function form(Form $form): Form
    {
        return \App\Filament\Modules\Inventaris\Resources\DeviceResource\Schemas\DeviceForm::configure($form);
    }

    public static function table(Table $table): Table
    {
        return \App\Filament\Modules\Inventaris\Resources\DeviceResource\Tables\DeviceTable::configure($table);
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return \App\Filament\Modules\Inventaris\Resources\DeviceResource\Infolists\DeviceInfolist::configure($infolist);
    }

    public static function getRelations(): array
    {
        return [
            RelationManagers\AttributeValuesRelationManager::class,
            RelationManagers\TicketsRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListDevices::route('/'),
            'create' => Pages\CreateDevice::route('/create'),
            'view' => Pages\ViewDevice::route('/{record}'),
            'edit' => Pages\EditDevice::route('/{record}/edit'),
        ];
    }
}
