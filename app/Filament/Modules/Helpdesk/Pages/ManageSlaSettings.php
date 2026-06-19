<?php

namespace App\Filament\Modules\Helpdesk\Pages;

use App\Filament\Concerns\HasModuleNavigationGate;
use App\Settings\SlaSettings;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
use Filament\Pages\SettingsPage;

class ManageSlaSettings extends SettingsPage
{
    use HasModuleNavigationGate, HasPageShield {
        HasModuleNavigationGate::shouldRegisterNavigation insteadof HasPageShield;
        HasModuleNavigationGate::shouldRegisterNavigation as protected shouldRegisterByModuleNavigationGate;
        HasPageShield::shouldRegisterNavigation as protected shouldRegisterByShield;
    }

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::HELPDESK_SLA;

    protected static ?string $navigationIcon = 'heroicon-o-clock';

    protected static ?string $navigationGroup = 'IT Helpdesk';

    protected static ?string $title = 'SLA Helpdesk';

    protected static ?int $navigationSort = 3;

    protected static string $settings = SlaSettings::class;

    public static function shouldRegisterNavigation(): bool
    {
        return static::passesModuleNavigationGate()
            && static::shouldRegisterByShield();
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                TextInput::make('critical_hours')
                    ->label('SLA Prioritas Kritis')
                    ->numeric()
                    ->minValue(1)
                    ->suffix('jam')
                    ->required()
                    ->helperText('Batas waktu penyelesaian tiket prioritas kritis'),

                TextInput::make('high_hours')
                    ->label('SLA Prioritas Tinggi')
                    ->numeric()
                    ->minValue(1)
                    ->suffix('jam')
                    ->required()
                    ->helperText('Batas waktu penyelesaian tiket prioritas tinggi'),

                TextInput::make('medium_hours')
                    ->label('SLA Prioritas Sedang')
                    ->numeric()
                    ->minValue(1)
                    ->suffix('jam')
                    ->required()
                    ->helperText('Batas waktu penyelesaian tiket prioritas sedang'),

                TextInput::make('low_hours')
                    ->label('SLA Prioritas Rendah')
                    ->numeric()
                    ->minValue(1)
                    ->suffix('jam')
                    ->required()
                    ->helperText('Batas waktu penyelesaian tiket prioritas rendah'),
            ]);
    }
}
