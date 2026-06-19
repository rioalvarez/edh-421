<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceAttributeResource\Tables;

use Filament\Tables;
use Filament\Tables\Table;

class DeviceAttributeTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label('Nama')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('slug')
                    ->label('Slug')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('type')
                    ->label('Tipe')
                    ->badge()
                    ->formatStateUsing(fn (string $state): string => match ($state) {
                        'text' => 'Teks',
                        'number' => 'Angka',
                        'select' => 'Dropdown',
                        'boolean' => 'Boolean',
                        'date' => 'Tanggal',
                        'textarea' => 'Area Teks',
                        default => $state,
                    })
                    ->color(fn (string $state): string => match ($state) {
                        'text' => 'gray',
                        'number' => 'info',
                        'select' => 'warning',
                        'boolean' => 'success',
                        'date' => 'primary',
                        'textarea' => 'gray',
                        default => 'gray',
                    }),

                Tables\Columns\IconColumn::make('is_required')
                    ->label('Wajib')
                    ->boolean(),

                Tables\Columns\IconColumn::make('is_active')
                    ->label('Aktif')
                    ->boolean(),

                Tables\Columns\TextColumn::make('sort_order')
                    ->label('Urutan')
                    ->sortable(),

                Tables\Columns\TextColumn::make('values_count')
                    ->label('Digunakan Di')
                    ->counts('values')
                    ->suffix(' device'),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Dibuat Pada')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('type')
                    ->label('Tipe')
                    ->options([
                        'text' => 'Teks',
                        'number' => 'Angka',
                        'select' => 'Dropdown Select',
                        'boolean' => 'Toggle Ya/Tidak',
                        'date' => 'Tanggal',
                        'textarea' => 'Area Teks',
                    ]),

                Tables\Filters\TernaryFilter::make('is_active')
                    ->label('Status Aktif'),

                Tables\Filters\TernaryFilter::make('is_required')
                    ->label('Status Wajib'),
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
            ->defaultSort('sort_order')
            ->reorderable('sort_order');
    }
}
