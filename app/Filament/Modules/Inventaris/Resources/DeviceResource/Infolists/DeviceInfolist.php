<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceResource\Infolists;

use App\Enums\DeviceCondition;
use App\Enums\DeviceStatus;
use App\Enums\DeviceType;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;

class DeviceInfolist
{
    public static function configure(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                // ── Informasi Dasar ───────────────────────────────────────────
                Section::make('Informasi Dasar')->schema([
                    TextEntry::make('type')
                        ->label('Tipe')
                        ->badge()
                        ->formatStateUsing(fn ($state) => DeviceType::tryLabel($state))
                        ->color(fn ($state) => DeviceType::tryColor($state)),
                    TextEntry::make('user.name')->label('User')->default('Belum Ada'),
                    TextEntry::make('hostname')->label('Hostname / Nama')->default('-'),
                    TextEntry::make('brand')->label('Merek')->default('-'),
                    TextEntry::make('model')->label('Model')->default('-'),
                    TextEntry::make('serial_number')->label('Nomor Seri')->default('-'),
                    TextEntry::make('asset_tag')->label('Tag Aset')->default('-'),
                    TextEntry::make('location')->label('Lokasi')->default('-'),
                    TextEntry::make('unit.name')->label('Unit Penanggung Jawab')->default('-'),
                ])->columns(2),

                // ── Koneksi Jaringan (komputer + perangkat jaringan) ─────────
                Section::make('Koneksi Jaringan')->schema([
                    TextEntry::make('ip_address')->label('IP Address')->default('-'),
                    TextEntry::make('mac_address')->label('MAC Address')->default('-'),
                ])->columns(2)
                    ->visible(fn ($record) => in_array($record->type, DeviceType::networkCapableValues(), true)),

                // ── Spesifikasi Komputer ──────────────────────────────────────
                Section::make('Spesifikasi Komputer')->schema([
                    TextEntry::make('os')->label('Sistem Operasi')->default('-'),
                    TextEntry::make('os_version')->label('Versi OS')->default('-'),
                    TextEntry::make('processor')->label('Prosesor')->default('-'),
                    TextEntry::make('ram')->label('RAM')->default('-'),
                    TextEntry::make('storage_type')->label('Tipe Penyimpanan')->default('-'),
                    TextEntry::make('storage_capacity')->label('Kapasitas Penyimpanan')->default('-'),
                ])->columns(2)
                    ->visible(fn ($record) => in_array($record->type, DeviceType::computerValues(), true)),

                // ── Spesifikasi Printer / Scanner ─────────────────────────────
                Section::make('Spesifikasi Printer / Scanner')->schema([
                    TextEntry::make('printer_connection')
                        ->label('Jenis Koneksi')
                        ->default('-')
                        ->formatStateUsing(fn ($state) => match ($state) {
                            'USB' => 'USB',
                            'Network' => 'Jaringan (LAN)',
                            'Wireless' => 'Wireless / WiFi',
                            'Bluetooth' => 'Bluetooth',
                            default => $state,
                        }),
                    TextEntry::make('printer_function')->label('Fungsi')->default('-'),
                ])->columns(2)
                    ->visible(fn ($record) => in_array($record->type, DeviceType::printerValues(), true)),

                // ── Status & Tanggal ──────────────────────────────────────────
                Section::make('Status & Tanggal')->schema([
                    TextEntry::make('condition')
                        ->label('Kondisi')
                        ->badge()
                        ->formatStateUsing(fn ($state) => DeviceCondition::tryLabel($state))
                        ->color(fn ($state) => DeviceCondition::tryColor($state)),
                    TextEntry::make('status')
                        ->label('Status')
                        ->badge()
                        ->formatStateUsing(fn ($state) => DeviceStatus::tryLabel($state))
                        ->color(fn ($state) => DeviceStatus::tryColor($state)),
                    TextEntry::make('purchase_date')->label('Tanggal Pembelian')->date()->placeholder('-'),
                    TextEntry::make('warranty_expiry')->label('Habis Masa Garansi')->date()->placeholder('-'),
                ])->columns(2),

                // ── Catatan ───────────────────────────────────────────────────
                Section::make('Catatan')->schema([
                    TextEntry::make('notes')
                        ->label('Catatan')
                        ->columnSpanFull()
                        ->default('Tidak ada catatan'),
                ])->collapsible(),
            ]);
    }
}
