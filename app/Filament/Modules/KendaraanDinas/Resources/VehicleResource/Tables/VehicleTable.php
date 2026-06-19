<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleResource\Tables;

use App\Enums\VehicleCondition;
use App\Enums\VehicleFuelType;
use App\Enums\VehicleOwnership;
use App\Enums\VehicleStatus;
use Filament\Tables;
use Filament\Tables\Table;

class VehicleTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\ImageColumn::make('image')
                    ->label('Foto')
                    ->circular()
                    ->defaultImageUrl(fn () => 'https://ui-avatars.com/api/?name=KDO&background=random'),

                Tables\Columns\TextColumn::make('plate_number')
                    ->label('No. Plat')
                    ->searchable()
                    ->sortable()
                    ->weight('bold'),

                Tables\Columns\TextColumn::make('brand')
                    ->label('Merk')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('model')
                    ->label('Model')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('year')
                    ->label('Tahun')
                    ->sortable()
                    ->toggleable(),

                Tables\Columns\TextColumn::make('capacity')
                    ->label('Kapasitas')
                    ->suffix(' org')
                    ->alignCenter()
                    ->toggleable(),

                Tables\Columns\TextColumn::make('fuel_type')
                    ->label('BBM')
                    ->badge()
                    ->formatStateUsing(fn (string $state): string => VehicleFuelType::tryLabel($state) ?? $state)
                    ->color(fn (string $state): string => VehicleFuelType::tryColor($state))
                    ->toggleable(),

                Tables\Columns\TextColumn::make('condition')
                    ->label('Kondisi')
                    ->badge()
                    ->formatStateUsing(fn (string $state): string => VehicleCondition::tryLabel($state) ?? $state)
                    ->color(fn (string $state): string => VehicleCondition::tryColor($state)),

                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->formatStateUsing(fn (string $state): string => VehicleStatus::tryLabel($state) ?? $state)
                    ->color(fn (string $state): string => VehicleStatus::tryColor($state)),

                Tables\Columns\TextColumn::make('tax_expiry_date')
                    ->label('Pajak')
                    ->date('d M Y')
                    ->sortable()
                    ->color(fn ($record) => $record?->isTaxExpired() ? 'danger' : ($record?->tax_expiry_warning ? 'warning' : null))
                    ->toggleable(),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Dibuat')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->label('Status')
                    ->options(VehicleStatus::options()),

                Tables\Filters\SelectFilter::make('condition')
                    ->label('Kondisi')
                    ->options(VehicleCondition::options()),

                Tables\Filters\SelectFilter::make('fuel_type')
                    ->label('Jenis BBM')
                    ->options(VehicleFuelType::options()),

                Tables\Filters\SelectFilter::make('ownership')
                    ->label('Kepemilikan')
                    ->options(VehicleOwnership::options()),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('created_at', 'desc');
    }
}
