<?php

namespace App\Filament\Modules\ManajemenUser\Resources\UserResource\Infolists;

use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;

class UserInfolist
{
    public static function configure(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Section::make('Informasi User')
                    ->schema([
                        TextEntry::make('name')->label('Nama'),
                        TextEntry::make('nip')
                            ->label('NIP')
                            ->copyable()
                            ->copyMessage('NIP disalin')
                            ->copyMessageDuration(1500)
                            ->icon('heroicon-o-identification'),
                        TextEntry::make('phone_number')
                            ->label('No. HP')
                            ->icon('heroicon-m-phone')
                            ->placeholder('-'),
                        TextEntry::make('email')
                            ->label('Email')
                            ->icon('heroicon-m-envelope')
                            ->placeholder('-'),
                        TextEntry::make('roles.name')
                            ->label('Role')
                            ->icon('heroicon-o-shield-check'),
                    ])->columns(2),
            ]);
    }
}
