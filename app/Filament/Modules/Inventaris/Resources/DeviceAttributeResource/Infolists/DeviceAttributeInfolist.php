<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceAttributeResource\Infolists;

use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;

class DeviceAttributeInfolist
{
    public static function configure(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Section::make('Informasi Atribut')->schema([
                    TextEntry::make('name')->label('Nama'),
                    TextEntry::make('slug')->label('Slug'),
                    TextEntry::make('type')->label('Tipe')->badge(),
                    TextEntry::make('sort_order')->label('Urutan'),
                ])->columns(2),

                Section::make('Opsi')->schema([
                    TextEntry::make('options')
                        ->badge()
                        ->separator(',')
                        ->default('Tidak ada opsi'),
                ])->visible(fn ($record) => $record->type === 'select'),

                Section::make('Pengaturan')->schema([
                    TextEntry::make('is_required')
                        ->label('Wajib')
                        ->badge()
                        ->formatStateUsing(fn ($state) => $state ? 'Ya' : 'Tidak')
                        ->color(fn ($state) => $state ? 'success' : 'gray'),
                    TextEntry::make('is_active')
                        ->label('Aktif')
                        ->badge()
                        ->formatStateUsing(fn ($state) => $state ? 'Ya' : 'Tidak')
                        ->color(fn ($state) => $state ? 'success' : 'gray'),
                ])->columns(2),
            ]);
    }
}
