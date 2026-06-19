<?php

namespace App\Filament\Modules\KendaraanDinas\Resources;

use App\Filament\Concerns\HasModuleNavigationGate;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleResource\Infolists\VehicleInfolist;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleResource\Pages;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleResource\Schemas\VehicleForm;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleResource\Tables\VehicleTable;
use App\Models\Vehicle;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;
use Filament\Forms\Form;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables\Table;

class VehicleResource extends Resource implements HasShieldPermissions
{
    use HasModuleNavigationGate;

    protected static ?string $model = Vehicle::class;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::VEHICLES_MASTER;

    protected static ?string $navigationIcon = 'heroicon-o-truck';

    protected static ?string $navigationGroup = 'Kendaraan Dinas';

    protected static ?int $navigationSort = 1;

    protected static ?string $navigationLabel = 'Master Kendaraan';

    protected static ?string $modelLabel = 'Kendaraan';

    protected static ?string $pluralModelLabel = 'Kendaraan';

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
        return VehicleForm::configure($form);
    }

    public static function table(Table $table): Table
    {
        return VehicleTable::configure($table);
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return VehicleInfolist::configure($infolist);
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
            'index' => Pages\ListVehicles::route('/'),
            'create' => Pages\CreateVehicle::route('/create'),
            'view' => Pages\ViewVehicle::route('/{record}'),
            'edit' => Pages\EditVehicle::route('/{record}/edit'),
        ];
    }
}
