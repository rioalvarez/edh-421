<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleResource\Schemas;

use App\Enums\VehicleCondition;
use App\Enums\VehicleFuelType;
use App\Enums\VehicleOwnership;
use App\Enums\VehicleStatus;
use Filament\Forms;
use Filament\Forms\Form;

class VehicleForm
{
    public static function configure(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Informasi Kendaraan')
                    ->schema([
                        Forms\Components\TextInput::make('plate_number')
                            ->label('Nomor Plat')
                            ->required()
                            ->unique(ignoreRecord: true)
                            ->maxLength(20)
                            ->placeholder('Contoh: B 1234 ABC'),

                        Forms\Components\TextInput::make('brand')
                            ->label('Merk')
                            ->required()
                            ->maxLength(100)
                            ->placeholder('Contoh: Toyota, Honda'),

                        Forms\Components\TextInput::make('model')
                            ->label('Model')
                            ->required()
                            ->maxLength(100)
                            ->placeholder('Contoh: Avanza, Innova'),

                        Forms\Components\TextInput::make('year')
                            ->label('Tahun')
                            ->numeric()
                            ->minValue(1990)
                            ->maxValue(date('Y') + 1)
                            ->placeholder('Contoh: 2022'),

                        Forms\Components\TextInput::make('color')
                            ->label('Warna')
                            ->maxLength(50)
                            ->placeholder('Contoh: Hitam, Putih'),

                        Forms\Components\TextInput::make('capacity')
                            ->label('Kapasitas Penumpang')
                            ->numeric()
                            ->default(4)
                            ->minValue(1)
                            ->maxValue(20)
                            ->suffix('orang'),
                    ])->columns(2),

                Forms\Components\Section::make('Detail Kendaraan')
                    ->schema([
                        Forms\Components\Select::make('fuel_type')
                            ->label('Jenis BBM')
                            ->options(VehicleFuelType::options())
                            ->default(VehicleFuelType::Bensin->value)
                            ->required(),

                        Forms\Components\Select::make('ownership')
                            ->label('Status Kepemilikan')
                            ->options(VehicleOwnership::options())
                            ->default(VehicleOwnership::Dinas->value)
                            ->required(),

                        Forms\Components\Select::make('condition')
                            ->label('Kondisi')
                            ->options(VehicleCondition::options())
                            ->default(VehicleCondition::Good->value)
                            ->required(),

                        Forms\Components\Select::make('status')
                            ->label('Status')
                            ->options(VehicleStatus::options())
                            ->default(VehicleStatus::Available->value)
                            ->required(),
                    ])->columns(2),

                Forms\Components\Section::make('Tanggal Penting')
                    ->schema([
                        Forms\Components\DatePicker::make('last_service_date')
                            ->label('Tanggal Servis Terakhir'),

                        Forms\Components\DatePicker::make('tax_expiry_date')
                            ->label('Tanggal Pajak Habis'),

                        Forms\Components\DatePicker::make('inspection_expiry_date')
                            ->label('Tanggal KIR Habis'),
                    ])->columns(3),

                Forms\Components\Section::make('Gambar & Catatan')
                    ->schema([
                        Forms\Components\FileUpload::make('image')
                            ->label('Foto Kendaraan')
                            ->image()
                            ->imageResizeMode('cover')
                            ->imageCropAspectRatio('16:9')
                            ->imageResizeTargetWidth('1280')
                            ->imageResizeTargetHeight('720')
                            ->directory('vehicles')
                            ->columnSpanFull(),

                        Forms\Components\Textarea::make('notes')
                            ->label('Catatan')
                            ->rows(3)
                            ->columnSpanFull()
                            ->placeholder('Catatan tambahan tentang kendaraan ini...'),
                    ])->collapsible(),
            ]);
    }
}
