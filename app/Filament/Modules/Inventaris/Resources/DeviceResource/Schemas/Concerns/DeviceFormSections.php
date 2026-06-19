<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceResource\Schemas\Concerns;

use App\Enums\DeviceCondition;
use App\Enums\DeviceStatus;
use App\Enums\DeviceType;
use App\Models\DeviceAttribute;
use Filament\Forms;

class DeviceFormSections
{
    public static function make(): array
    {
        $isKomputer = fn (Forms\Get $get) => in_array($get('type'), DeviceType::computerValues(), true);
        $isPrinter = fn (Forms\Get $get) => in_array($get('type'), DeviceType::printerValues(), true);
        $hasNetwork = fn (Forms\Get $get) => in_array($get('type'), DeviceType::networkCapableValues(), true);

        return [
            self::basicInformation(),
            self::networkInformation($hasNetwork),
            self::computerSpecifications($isKomputer),
            self::printerSpecifications($isPrinter),
            self::statusDates(),
            self::dynamicAttributes(),
            self::notes(),
        ];
    }

    private static function basicInformation(): Forms\Components\Section
    {
        return Forms\Components\Section::make('Informasi Dasar')
            ->schema([
                Forms\Components\Select::make('type')
                    ->label('Tipe Perangkat')
                    ->options(DeviceType::groupedOptions())
                    ->required()
                    ->default(DeviceType::Desktop->value)
                    ->live(),

                Forms\Components\Select::make('user_id')
                    ->label('User')
                    ->relationship('user', 'name')
                    ->searchable()
                    ->preload()
                    ->nullable()
                    ->helperText('Kosongkan jika perangkat belum digunakan'),

                Forms\Components\TextInput::make('hostname')
                    ->label(fn (Forms\Get $get) => match (true) {
                        in_array($get('type'), DeviceType::printerValues(), true) => 'Nama Printer/Scanner',
                        in_array($get('type'), [DeviceType::Other->value], true) => 'Nama Perangkat',
                        default => 'Hostname',
                    })
                    ->required()
                    ->maxLength(255)
                    ->placeholder(fn (Forms\Get $get) => match (true) {
                        in_array($get('type'), DeviceType::printerValues(), true) => 'cth: Printer-LT2, Canon-MX',
                        in_array($get('type'), [DeviceType::Other->value], true) => 'cth: Proyektor-R1',
                        default => 'cth: PC150421XXX',
                    }),

                Forms\Components\TextInput::make('brand')
                    ->label('Merek')
                    ->maxLength(255)
                    ->placeholder(fn (Forms\Get $get) => match (true) {
                        in_array($get('type'), DeviceType::printerValues(), true) => 'cth: Canon, Epson, HP',
                        in_array($get('type'), DeviceType::networkValues(), true) => 'cth: Cisco, TP-Link, Mikrotik',
                        default => 'cth: Dell, HP, Lenovo',
                    }),

                Forms\Components\TextInput::make('model')
                    ->label('Model')
                    ->maxLength(255)
                    ->placeholder('cth: MX922, RB750, Latitude 5520'),

                Forms\Components\TextInput::make('serial_number')
                    ->label('Nomor Seri')
                    ->maxLength(255)
                    ->unique(ignoreRecord: true)
                    ->placeholder('cth: ABC123XYZ'),

                Forms\Components\TextInput::make('asset_tag')
                    ->label('Tag Aset')
                    ->maxLength(255)
                    ->unique(ignoreRecord: true)
                    ->placeholder('cth: AST-2024-001'),

                Forms\Components\TextInput::make('location')
                    ->label('Lokasi')
                    ->maxLength(255)
                    ->datalist(['Lantai 1', 'Lantai 2', 'Lantai 3', 'Lantai 4', 'Basement'])
                    ->placeholder('cth: Lantai 2'),

                Forms\Components\Select::make('unit_id')
                    ->label('Unit Penanggung Jawab')
                    ->relationship('unit', 'name')
                    ->searchable()
                    ->preload()
                    ->nullable()
                    ->createOptionForm([
                        Forms\Components\TextInput::make('name')
                            ->label('Nama Unit')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\TextInput::make('code')
                            ->label('Kode Unit')
                            ->maxLength(50),
                    ])
                    ->helperText('Unit/seksi yang bertanggung jawab atas perangkat ini'),
            ])
            ->columns(2);
    }

    private static function networkInformation(callable $hasNetwork): Forms\Components\Section
    {
        return Forms\Components\Section::make('Koneksi Jaringan')
            ->schema([
                Forms\Components\TextInput::make('ip_address')
                    ->label('IP Address')
                    ->ip()
                    ->maxLength(45)
                    ->required(fn (Forms\Get $get) => in_array($get('type'), DeviceType::networkValues(), true))
                    ->placeholder('cth: 10.9.1.XXX'),

                Forms\Components\TextInput::make('mac_address')
                    ->label('MAC Address')
                    ->maxLength(17)
                    ->placeholder('cth: 00:1A:2B:3C:4D:5E'),
            ])
            ->columns(2)
            ->visible($hasNetwork);
    }

    private static function computerSpecifications(callable $isKomputer): Forms\Components\Section
    {
        return Forms\Components\Section::make('Spesifikasi Komputer')
            ->schema([
                Forms\Components\TextInput::make('os')
                    ->label('Sistem Operasi')
                    ->maxLength(255)
                    ->placeholder('cth: Windows 11 Pro'),

                Forms\Components\TextInput::make('os_version')
                    ->label('Versi OS')
                    ->maxLength(255)
                    ->placeholder('cth: 22H2'),

                Forms\Components\TextInput::make('processor')
                    ->label('Prosesor')
                    ->maxLength(255)
                    ->placeholder('cth: Intel Core i7-1165G7'),

                Forms\Components\TextInput::make('ram')
                    ->label('RAM')
                    ->maxLength(255)
                    ->placeholder('cth: 16GB DDR4'),

                Forms\Components\Select::make('storage_type')
                    ->label('Tipe Penyimpanan')
                    ->options([
                        'SSD' => 'SSD',
                        'HDD' => 'HDD',
                        'NVMe' => 'NVMe',
                        'Hybrid' => 'Hybrid',
                    ])
                    ->placeholder('Pilih tipe penyimpanan'),

                Forms\Components\TextInput::make('storage_capacity')
                    ->label('Kapasitas Penyimpanan')
                    ->maxLength(255)
                    ->placeholder('cth: 512GB'),
            ])
            ->columns(2)
            ->visible($isKomputer);
    }

    private static function printerSpecifications(callable $isPrinter): Forms\Components\Section
    {
        return Forms\Components\Section::make('Spesifikasi Printer / Scanner')
            ->schema([
                Forms\Components\Select::make('printer_connection')
                    ->label('Jenis Koneksi')
                    ->options([
                        'USB' => 'USB',
                        'Network' => 'Jaringan (LAN)',
                        'Wireless' => 'Wireless / WiFi',
                        'Bluetooth' => 'Bluetooth',
                    ])
                    ->placeholder('Pilih jenis koneksi')
                    ->helperText('Cara printer terhubung ke komputer'),

                Forms\Components\TextInput::make('printer_function')
                    ->label('Fungsi')
                    ->placeholder('cth: Print, Scan, Copy, Fax')
                    ->helperText('Fungsi yang didukung perangkat')
                    ->maxLength(255),
            ])
            ->columns(2)
            ->visible($isPrinter);
    }

    private static function statusDates(): Forms\Components\Section
    {
        return Forms\Components\Section::make('Status & Tanggal')
            ->schema([
                Forms\Components\Select::make('condition')
                    ->label('Kondisi')
                    ->options(DeviceCondition::options())
                    ->default(DeviceCondition::Good->value)
                    ->required(),

                Forms\Components\Select::make('status')
                    ->label('Status')
                    ->options(DeviceStatus::options())
                    ->default(DeviceStatus::Active->value)
                    ->required(),

                Forms\Components\DatePicker::make('purchase_date')
                    ->label('Tanggal Pembelian'),

                Forms\Components\DatePicker::make('warranty_expiry')
                    ->label('Habis Masa Garansi'),
            ])
            ->columns(2);
    }

    private static function dynamicAttributes(): Forms\Components\Section
    {
        return Forms\Components\Section::make('Atribut Tambahan')
            ->schema(fn () => DeviceAttribute::active()->ordered()->get()
                ->map(fn (DeviceAttribute $attribute) => self::dynamicAttributeField($attribute))
                ->all())
            ->columns(2)
            ->visible(fn () => DeviceAttribute::active()->exists());
    }

    private static function notes(): Forms\Components\Section
    {
        return Forms\Components\Section::make('Catatan')
            ->schema([
                Forms\Components\Textarea::make('notes')
                    ->hiddenLabel()
                    ->columnSpanFull()
                    ->rows(3)
                    ->placeholder('Catatan tambahan tentang perangkat ini...'),
            ])
            ->collapsible();
    }

    private static function dynamicAttributeField(DeviceAttribute $attribute)
    {
        return match ($attribute->type) {
            'text' => Forms\Components\TextInput::make("dynamic_attributes.{$attribute->slug}")
                ->label($attribute->name)
                ->required($attribute->is_required),
            'number' => Forms\Components\TextInput::make("dynamic_attributes.{$attribute->slug}")
                ->label($attribute->name)
                ->numeric()
                ->required($attribute->is_required),
            'textarea' => Forms\Components\Textarea::make("dynamic_attributes.{$attribute->slug}")
                ->label($attribute->name)
                ->required($attribute->is_required),
            'select' => Forms\Components\Select::make("dynamic_attributes.{$attribute->slug}")
                ->label($attribute->name)
                ->options(collect($attribute->options ?? [])->mapWithKeys(fn ($option) => [$option => $option])->all())
                ->required($attribute->is_required),
            'boolean' => Forms\Components\Toggle::make("dynamic_attributes.{$attribute->slug}")
                ->label($attribute->name)
                ->required($attribute->is_required),
            'date' => Forms\Components\DatePicker::make("dynamic_attributes.{$attribute->slug}")
                ->label($attribute->name)
                ->required($attribute->is_required),
        };
    }
}
