<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Infolists;

use App\Enums\FuelLevel;
use App\Enums\VehicleBookingStatus;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;

class VehicleBookingInfolist
{
    public static function configure(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Section::make('Informasi Peminjaman')
                    ->schema([
                        TextEntry::make('booking_number')
                            ->label('Nomor Peminjaman')
                            ->weight('bold')
                            ->copyable(),
                        TextEntry::make('user.name')
                            ->label('Pemohon'),
                        TextEntry::make('status')
                            ->label('Status')
                            ->badge()
                            ->formatStateUsing(fn (string $state): string => VehicleBookingStatus::tryLabel($state) ?? $state)
                            ->color(fn (string $state): string => VehicleBookingStatus::tryColor($state)),
                        TextEntry::make('created_at')
                            ->label('Dibuat')
                            ->dateTime('d M Y H:i'),
                    ])->columns(4),

                Section::make('Data Kendaraan')
                    ->schema([
                        TextEntry::make('vehicle.plate_number')
                            ->label('Nomor Plat'),
                        TextEntry::make('vehicle.brand')
                            ->label('Merk'),
                        TextEntry::make('vehicle.model')
                            ->label('Model'),
                        TextEntry::make('vehicle.color')
                            ->label('Warna')
                            ->default('-'),
                    ])->columns(4),

                Section::make('Jadwal Perjalanan')
                    ->schema([
                        TextEntry::make('start_date')
                            ->label('Tanggal Mulai')
                            ->date('d M Y'),
                        TextEntry::make('end_date')
                            ->label('Tanggal Selesai')
                            ->date('d M Y'),
                        TextEntry::make('departure_time')
                            ->label('Jam Keberangkatan')
                            ->time('H:i')
                            ->placeholder('-'),
                        TextEntry::make('duration_days')
                            ->label('Durasi')
                            ->suffix(' hari'),
                    ])->columns(4),

                Section::make('Data Surat Tugas')
                    ->schema([
                        TextEntry::make('document_number')
                            ->label('Nomor Surat'),
                        TextEntry::make('destination')
                            ->label('Alamat Tujuan'),
                        TextEntry::make('purpose')
                            ->label('Keperluan')
                            ->columnSpanFull(),
                    ])->columns(2),

                Section::make('Data Pengemudi & Penumpang')
                    ->schema([
                        TextEntry::make('driver_name')
                            ->label('Nama Pengemudi'),
                        TextEntry::make('driver_phone')
                            ->label('No. Telepon')
                            ->default('-'),
                        TextEntry::make('passengers_list')
                            ->label('Daftar Penumpang')
                            ->columnSpanFull(),
                    ])->columns(2),

                Section::make('Data Odometer & BBM')
                    ->schema([
                        TextEntry::make('start_odometer')
                            ->label('KM Awal')
                            ->suffix(' km')
                            ->default('-'),
                        TextEntry::make('end_odometer')
                            ->label('KM Akhir')
                            ->suffix(' km')
                            ->default('-'),
                        TextEntry::make('distance_traveled')
                            ->label('Jarak Tempuh')
                            ->suffix(' km')
                            ->default('-'),
                        TextEntry::make('fuel_level')
                            ->label('Level BBM')
                            ->formatStateUsing(fn (?string $state): string => FuelLevel::tryLabel($state) ?? '-')
                            ->badge()
                            ->color(fn (?string $state): string => FuelLevel::tryColor($state)),
                    ])->columns(4)
                    ->visible(fn ($record) => $record->start_odometer || $record->end_odometer || $record->fuel_level),

                Section::make('Pengembalian')
                    ->schema([
                        TextEntry::make('returned_at')
                            ->label('Waktu Pengembalian')
                            ->dateTime('d M Y H:i')
                            ->placeholder('-'),
                        TextEntry::make('return_condition')
                            ->label('Kondisi Kendaraan')
                            ->default('-'),
                        TextEntry::make('return_notes')
                            ->label('Catatan Pengembalian')
                            ->default('-')
                            ->columnSpanFull(),
                    ])->columns(2)
                    ->visible(fn ($record) => $record->status === VehicleBookingStatus::Completed->value),

                Section::make('Pembatalan')
                    ->schema([
                        TextEntry::make('cancellation_reason')
                            ->label('Alasan Pembatalan')
                            ->columnSpanFull(),
                    ])
                    ->visible(fn ($record) => $record->status === VehicleBookingStatus::Cancelled->value),

                Section::make('Catatan')
                    ->schema([
                        TextEntry::make('notes')
                            ->label('Catatan Tambahan')
                            ->default('Tidak ada catatan')
                            ->columnSpanFull(),
                    ])
                    ->collapsible(),
            ]);
    }
}
