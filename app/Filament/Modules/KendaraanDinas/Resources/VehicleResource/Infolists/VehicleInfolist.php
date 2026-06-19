<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleResource\Infolists;

use App\Enums\VehicleCondition;
use App\Enums\VehicleFuelType;
use App\Enums\VehicleOwnership;
use App\Enums\VehicleStatus;
use Filament\Infolists\Components\ImageEntry;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;

class VehicleInfolist
{
    public static function configure(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Section::make('Informasi Kendaraan')
                    ->schema([
                        ImageEntry::make('image')
                            ->label('Foto')
                            ->columnSpanFull()
                            ->height(200),
                        TextEntry::make('plate_number')->label('Nomor Plat')->weight('bold'),
                        TextEntry::make('brand')->label('Merk'),
                        TextEntry::make('model')->label('Model'),
                        TextEntry::make('year')->label('Tahun')->default('-'),
                        TextEntry::make('color')->label('Warna')->default('-'),
                        TextEntry::make('capacity')->label('Kapasitas')->suffix(' orang'),
                    ])->columns(2),

                Section::make('Detail Kendaraan')
                    ->schema([
                        TextEntry::make('fuel_type')
                            ->label('Jenis BBM')
                            ->badge()
                            ->color(fn (string $state): string => VehicleFuelType::tryColor($state))
                            ->formatStateUsing(fn (string $state): string => VehicleFuelType::tryLabel($state) ?? $state),
                        TextEntry::make('ownership')
                            ->label('Kepemilikan')
                            ->badge()
                            ->formatStateUsing(fn (string $state): string => VehicleOwnership::tryLabel($state) ?? $state),
                        TextEntry::make('condition')
                            ->label('Kondisi')
                            ->badge()
                            ->color(fn (string $state): string => VehicleCondition::tryColor($state))
                            ->formatStateUsing(fn (string $state): string => VehicleCondition::tryLabel($state) ?? $state),
                        TextEntry::make('status')
                            ->label('Status')
                            ->badge()
                            ->color(fn (string $state): string => VehicleStatus::tryColor($state))
                            ->formatStateUsing(fn (string $state): string => VehicleStatus::tryLabel($state) ?? $state),
                    ])->columns(2),

                Section::make('Tanggal Penting')
                    ->schema([
                        TextEntry::make('last_service_date')->label('Servis Terakhir')->date('d M Y')->placeholder('-'),
                        TextEntry::make('tax_expiry_date')->label('Pajak Habis')->date('d M Y')->placeholder('-'),
                        TextEntry::make('inspection_expiry_date')->label('KIR Habis')->date('d M Y')->placeholder('-'),
                    ])->columns(3),

                Section::make('Catatan')
                    ->schema([
                        TextEntry::make('notes')->label('Catatan')->default('Tidak ada catatan')->columnSpanFull(),
                    ])->collapsible(),
            ]);
    }
}
