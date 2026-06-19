<?php

namespace App\Filament\Modules\Pengaturan\Pages;

use App\Settings\ModuleSettings;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use Filament\Forms\Components\Toggle;
use Filament\Forms\Form;
use Filament\Pages\SettingsPage;

class ManageModuleSettings extends SettingsPage
{
    use HasPageShield;

    protected static ?string $navigationIcon = 'heroicon-o-adjustments-vertical';

    protected static ?string $navigationGroup = 'Pengaturan';

    protected static ?string $title = 'Modul Layanan';

    protected static ?string $navigationLabel = 'Modul Layanan';

    protected static ?int $navigationSort = 2;

    protected static string $settings = ModuleSettings::class;

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Toggle::make('enable_vehicle_booking')
                    ->label('Aktifkan Peminjaman KDO')
                    ->helperText('Aktifkan atau nonaktifkan modul Peminjaman Kendaraan Dinas.'),
                Toggle::make('enable_helpdesk_tickets')
                    ->label('Aktifkan Tiket Helpdesk')
                    ->helperText('Aktifkan atau nonaktifkan modul Tiket Helpdesk.'),
                Toggle::make('enable_inventory')
                    ->label('Aktifkan Inventaris IT')
                    ->helperText('Aktifkan atau nonaktifkan modul Inventaris Perangkat IT.'),
                Toggle::make('enable_blog')
                    ->label('Aktifkan Blog/Artikel')
                    ->helperText('Aktifkan atau nonaktifkan modul Artikel/Basis Pengetahuan.'),
                Toggle::make('enable_user_management')
                    ->label('Aktifkan Manajemen User')
                    ->helperText('Aktifkan atau nonaktifkan modul Manajemen User dan Peran.'),
            ]);
    }
}
