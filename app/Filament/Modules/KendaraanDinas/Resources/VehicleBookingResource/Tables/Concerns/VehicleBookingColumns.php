<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Tables\Concerns;

use App\Enums\VehicleBookingStatus;
use App\Models\VehicleBooking;
use Filament\Tables;

class VehicleBookingColumns
{
    public static function make(): array
    {
        return [
            Tables\Columns\TextColumn::make('booking_number')
                ->label('No. Peminjaman')
                ->searchable()
                ->sortable()
                ->weight('bold')
                ->copyable(),

            Tables\Columns\TextColumn::make('user.name')
                ->label('Pemohon')
                ->searchable()
                ->sortable(),

            Tables\Columns\TextColumn::make('vehicle.plate_number')
                ->label('No. Plat')
                ->searchable()
                ->sortable(),

            Tables\Columns\TextColumn::make('vehicle.brand')
                ->label('Kendaraan')
                ->formatStateUsing(fn (VehicleBooking $record) => $record->vehicleName())
                ->toggleable(),

            Tables\Columns\TextColumn::make('destination')
                ->label('Tujuan')
                ->limit(30)
                ->tooltip(fn (VehicleBooking $record) => $record->destination)
                ->searchable(),

            Tables\Columns\TextColumn::make('start_date')
                ->label('Tgl Mulai')
                ->date('d M Y')
                ->sortable(),

            Tables\Columns\TextColumn::make('end_date')
                ->label('Tgl Selesai')
                ->date('d M Y')
                ->sortable(),

            Tables\Columns\TextColumn::make('status')
                ->label('Status')
                ->badge()
                ->formatStateUsing(fn (string $state): string => VehicleBookingStatus::tryLabel($state) ?? $state)
                ->color(fn (string $state): string => VehicleBookingStatus::tryColor($state)),

            Tables\Columns\IconColumn::make('needs_return')
                ->label('Perlu Dikembalikan')
                ->boolean()
                ->state(fn (VehicleBooking $record) => $record->needsReturn())
                ->trueIcon('heroicon-o-exclamation-triangle')
                ->trueColor('danger')
                ->falseIcon('heroicon-o-check-circle')
                ->falseColor('success')
                ->toggleable(),

            Tables\Columns\TextColumn::make('created_at')
                ->label('Dibuat')
                ->dateTime('d M Y H:i')
                ->sortable()
                ->toggleable(isToggledHiddenByDefault: true),
        ];
    }
}
