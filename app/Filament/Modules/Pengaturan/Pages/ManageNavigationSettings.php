<?php

namespace App\Filament\Modules\Pengaturan\Pages;

use App\Settings\NavigationSettings;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Toggle;
use Filament\Forms\Form;
use Filament\Pages\SettingsPage;

class ManageNavigationSettings extends SettingsPage
{
    use HasPageShield;

    protected static ?string $navigationIcon = 'heroicon-o-bars-3';

    protected static ?string $navigationGroup = 'Pengaturan';

    protected static ?string $title = 'Manajemen Halaman';

    protected static ?int $navigationSort = 4;

    protected static string $settings = NavigationSettings::class;

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Section::make('IT Helpdesk')
                    ->icon('heroicon-o-ticket')
                    ->columns(2)
                    ->schema([
                        Toggle::make('show_helpdesk_tickets')
                            ->label('Tiket')
                            ->helperText('Menu daftar dan kelola tiket helpdesk.'),
                        Toggle::make('show_helpdesk_report')
                            ->label('Laporan Tiket')
                            ->helperText('Menu laporan dan statistik tiket.'),
                    ]),

                Section::make('Kendaraan Dinas')
                    ->icon('heroicon-o-truck')
                    ->columns(2)
                    ->schema([
                        Toggle::make('show_vehicle_master')
                            ->label('Master Kendaraan')
                            ->helperText('Menu data kendaraan dinas.'),
                        Toggle::make('show_vehicle_booking')
                            ->label('Peminjaman KDO')
                            ->helperText('Menu pengajuan dan kelola peminjaman.'),
                        Toggle::make('show_vehicle_calendar')
                            ->label('Kalender KDO')
                            ->helperText('Menu kalender jadwal pemakaian kendaraan.'),
                    ]),

                Section::make('Inventaris')
                    ->icon('heroicon-o-computer-desktop')
                    ->columns(2)
                    ->schema([
                        Toggle::make('show_inventory_devices')
                            ->label('Daftar Perangkat')
                            ->helperText('Menu utama daftar inventaris perangkat IT.'),
                        Toggle::make('show_inventory_attributes')
                            ->label('Setting Informasi Perangkat')
                            ->helperText('Menu konfigurasi atribut tambahan perangkat.'),
                        Toggle::make('show_inventory_units')
                            ->label('Unit Penanggung Jawab')
                            ->helperText('Menu manajemen unit/seksi pemilik perangkat.'),
                    ]),

                Section::make('Knowledge Management')
                    ->icon('heroicon-o-document-text')
                    ->columns(2)
                    ->schema([
                        Toggle::make('show_km_articles')
                            ->label('Artikel')
                            ->helperText('Menu artikel basis pengetahuan.'),
                        Toggle::make('show_km_categories')
                            ->label('Kategori Artikel')
                            ->helperText('Menu kategori pengelompokan artikel.'),
                    ]),

                Section::make('Manajemen User')
                    ->icon('heroicon-o-users')
                    ->columns(2)
                    ->schema([
                        Toggle::make('show_user_management')
                            ->label('User')
                            ->helperText('Menu data dan kelola akun user.'),
                        Toggle::make('show_role_management')
                            ->label('Peran & Izin')
                            ->helperText('Menu manajemen role dan permission.'),
                    ]),
            ]);
    }
}
