<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceResource\Tables;

use App\Filament\Modules\Inventaris\Resources\DeviceResource\Tables\Concerns\DeviceActions;
use App\Filament\Modules\Inventaris\Resources\DeviceResource\Tables\Concerns\DeviceColumns;
use App\Filament\Modules\Inventaris\Resources\DeviceResource\Tables\Concerns\DeviceFilters;
use Filament\Tables\Enums\FiltersLayout;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class DeviceTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->defaultSort(
                fn (Builder $query): Builder => $query
                    ->orderBy('created_at', 'desc')
                    ->orderBy('id', 'desc'),
            )
            ->defaultKeySort()
            ->columns(DeviceColumns::make())
            ->filters(DeviceFilters::make(), layout: FiltersLayout::Dropdown)
            ->filtersFormColumns(2)
            ->persistFiltersInSession()
            ->persistSortInSession()
            ->actions(DeviceActions::rowActions())
            ->headerActions(DeviceActions::headerActions())
            ->bulkActions(DeviceActions::bulkActions());
    }
}
