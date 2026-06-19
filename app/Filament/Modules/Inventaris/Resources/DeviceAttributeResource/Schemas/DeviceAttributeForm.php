<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceAttributeResource\Schemas;

use Filament\Forms;
use Filament\Forms\Form;
use Illuminate\Support\Str;

class DeviceAttributeForm
{
    public static function configure(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Informasi Atribut')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->label('Nama')
                            ->required()
                            ->maxLength(255)
                            ->live(onBlur: true)
                            ->afterStateUpdated(fn (Forms\Set $set, ?string $state) => $set('slug', Str::slug($state)))
                            ->placeholder('cth: GPU, Ukuran Monitor, Kunci Lisensi'),

                        Forms\Components\TextInput::make('slug')
                            ->label('Slug')
                            ->required()
                            ->maxLength(255)
                            ->unique(ignoreRecord: true)
                            ->helperText('Dibuat otomatis dari nama'),

                        Forms\Components\Select::make('type')
                            ->label('Tipe Input')
                            ->options([
                                'text' => 'Teks',
                                'number' => 'Angka',
                                'select' => 'Dropdown Select',
                                'boolean' => 'Toggle Ya/Tidak',
                                'date' => 'Tanggal',
                                'textarea' => 'Area Teks',
                            ])
                            ->required()
                            ->default('text')
                            ->live()
                            ->helperText('Pilih tipe input untuk atribut ini'),

                        Forms\Components\TextInput::make('sort_order')
                            ->label('Urutan')
                            ->numeric()
                            ->default(0)
                            ->helperText('Angka lebih kecil akan muncul lebih awal'),
                    ])->columns(2),

                Forms\Components\Section::make('Opsi Dropdown')
                    ->schema([
                        Forms\Components\TagsInput::make('options')
                            ->label('Opsi')
                            ->placeholder('Tambah opsi dan tekan Enter')
                            ->helperText('Masukkan setiap opsi untuk dropdown'),
                    ])
                    ->visible(fn (Forms\Get $get) => $get('type') === 'select'),

                Forms\Components\Section::make('Pengaturan')
                    ->schema([
                        Forms\Components\Toggle::make('is_required')
                            ->label('Wajib Diisi')
                            ->helperText('Jika diaktifkan, field ini harus diisi saat membuat/mengedit device'),

                        Forms\Components\Toggle::make('is_active')
                            ->label('Aktif')
                            ->default(true)
                            ->helperText('Atribut tidak aktif tidak akan muncul di form device'),
                    ])->columns(2),
            ]);
    }
}
