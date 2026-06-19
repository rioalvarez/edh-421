<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceResource\Tables\Concerns;

use App\Enums\DeviceCondition;
use App\Enums\DeviceStatus;
use App\Enums\DeviceType;
use Filament\Tables;

class DeviceColumns
{
    public static function make(): array
    {
        return [
            Tables\Columns\TextColumn::make('hostname')
                ->label('Hostname')
                ->searchable()
                ->sortable()
                ->default('-'),

            Tables\Columns\TextColumn::make('type')
                ->label('Tipe')
                ->badge()
                ->sortable()
                ->formatStateUsing(fn ($state) => DeviceType::tryLabel($state))
                ->color(fn ($state) => DeviceType::tryColor($state)),

            Tables\Columns\TextColumn::make('user.name')
                ->label('User')
                ->searchable()
                ->sortable()
                ->default('Belum Ada')
                ->badge()
                ->color(fn ($state) => $state === 'Belum Ada' ? 'gray' : 'success'),

            Tables\Columns\TextColumn::make('unit.name')
                ->label('Unit Penanggung Jawab')
                ->searchable()
                ->sortable()
                ->toggleable(isToggledHiddenByDefault: false)
                ->placeholder('-'),

            Tables\Columns\TextColumn::make('location')
                ->label('Lokasi')
                ->searchable()
                ->sortable()
                ->default('-'),

            Tables\Columns\TextColumn::make('ip_address')
                ->label('IP Address')
                ->searchable()
                ->sortable()
                ->toggleable(),

            Tables\Columns\TextColumn::make('brand')
                ->label('Merek')
                ->searchable()
                ->sortable()
                ->toggleable(isToggledHiddenByDefault: true),

            Tables\Columns\TextColumn::make('model')
                ->label('Model')
                ->searchable()
                ->sortable()
                ->toggleable(isToggledHiddenByDefault: true),

            Tables\Columns\TextColumn::make('serial_number')
                ->label('No. Seri')
                ->searchable()
                ->sortable()
                ->toggleable(isToggledHiddenByDefault: true),

            Tables\Columns\TextColumn::make('os')
                ->label('OS')
                ->limit(20)
                ->sortable()
                ->toggleable(),

            Tables\Columns\TextColumn::make('ram')
                ->label('RAM')
                ->sortable()
                ->toggleable(),

            Tables\Columns\TextColumn::make('condition')
                ->label('Kondisi')
                ->badge()
                ->sortable()
                ->formatStateUsing(fn ($state) => DeviceCondition::tryLabel($state))
                ->color(fn ($state) => DeviceCondition::tryColor($state)),

            Tables\Columns\TextColumn::make('status')
                ->label('Status')
                ->badge()
                ->sortable()
                ->formatStateUsing(fn ($state) => DeviceStatus::tryLabel($state))
                ->color(fn ($state) => DeviceStatus::tryColor($state)),

            Tables\Columns\TextColumn::make('warranty_expiry')
                ->label('Garansi')
                ->date()
                ->sortable()
                ->color(fn ($record) => $record?->isWarrantyExpired() ? 'danger' : null)
                ->toggleable(isToggledHiddenByDefault: true),

            Tables\Columns\TextColumn::make('created_at')
                ->label('Dibuat Pada')
                ->dateTime()
                ->sortable()
                ->toggleable(isToggledHiddenByDefault: true),
        ];
    }
}
