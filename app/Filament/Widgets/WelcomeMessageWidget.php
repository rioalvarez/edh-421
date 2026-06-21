<?php

namespace App\Filament\Widgets;

use App\Filament\Concerns\HasModuleWidgetGate;
use Filament\Widgets\Widget;
use Illuminate\Support\Facades\Auth;

class WelcomeMessageWidget extends Widget
{
    use HasModuleWidgetGate;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::HELPDESK_TICKETS;

    protected static string $view = 'filament.widgets.welcome-message-widget';

    protected static ?int $sort = 1;

    protected int|string|array $columnSpan = 'full';

    public static function canView(): bool
    {
        $user = Auth::user();

        if (! $user || $user->isItAdmin()) {
            return false;
        }

        return static::passesModuleWidgetGate();
    }
}
