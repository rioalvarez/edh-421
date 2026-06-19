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

        // Only show this widget if the helpdesk module is enabled AND
        // if the user is a 'Member' OR if they are not an Admin/Super_Admin
        // (i.e., if they are a user who would *not* see the TicketStatsWidget)
        // Dashboard admin & super_admin hanya menampilkan tiket terbaru — sapaan disembunyikan,
        // walaupun akun tersebut merangkap role Member.
        if ($user?->isItAdmin()) {
            return false;
        }

        if (static::passesModuleWidgetGate()) {
            // Check if the user is a 'Member'
            if ($user && $user->hasRole($user::ROLE_MEMBER)) {
                return true;
            }
            // Alternatively, show this to any user who doesn't see the TicketStatsWidget
            // This is a broader approach, assuming anyone not seeing ticket stats
            // should see a welcome message.
            if ($user && ! $user->isItAdmin()) {
                return true;
            }
        }

        return false;
    }
}
