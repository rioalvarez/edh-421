<?php

namespace App\Filament\Modules\Inventaris\Resources\UnitResource\Schemas;

use Filament\Forms;
use Filament\Forms\Form;

class UnitForm
{
    public static function configure(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Informasi Unit')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->label('Nama Unit')
                            ->required()
                            ->maxLength(255)
                            ->placeholder('cth: Seksi Pelayanan, Subbagian Umum, Seksi PDI'),

                        Forms\Components\TextInput::make('code')
                            ->label('Kode Unit')
                            ->maxLength(50)
                            ->unique(ignoreRecord: true)
                            ->placeholder('cth: SI-001, PDI, UMUM'),

                        Forms\Components\Textarea::make('description')
                            ->label('Keterangan')
                            ->columnSpanFull()
                            ->rows(3)
                            ->placeholder('Deskripsi singkat tentang unit ini...'),
                    ])->columns(2),
            ]);
    }
}
