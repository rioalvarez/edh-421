<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Tables;

use App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Tables\Concerns\VehicleBookingActions;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Tables\Concerns\VehicleBookingColumns;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Tables\Concerns\VehicleBookingFilters;
use Filament\Tables\Table;

class VehicleBookingTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns(VehicleBookingColumns::make())
            ->filters(VehicleBookingFilters::make())
            ->actions(VehicleBookingActions::rowActions())
            ->bulkActions(VehicleBookingActions::bulkActions())
            ->defaultSort('created_at', 'desc');
    }
}
