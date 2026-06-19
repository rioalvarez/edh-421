<?php

namespace App\Providers\Filament;

use App\Filament\Modules\Inventaris\Resources\DeviceResource\Pages\ListDevices;
use App\Filament\Pages\Login;
use App\Filament\Pages\Register;
use App\Filament\Pages\ThemeColorPage;
use App\Http\Middleware\ApplyUserThemeColor;
use App\Models\User;
use App\Settings\KaidoSetting;
use BezhanSalleh\FilamentShield\FilamentShieldPlugin;
use DutchCodingCompany\FilamentSocialite\FilamentSocialitePlugin;
use DutchCodingCompany\FilamentSocialite\Provider;
use Filament\Forms\Components\FileUpload;
use Filament\Http\Middleware\Authenticate;
use Filament\Http\Middleware\DisableBladeIconComponents;
use Filament\Http\Middleware\DispatchServingFilamentEvent;
use Filament\Navigation\NavigationGroup;
use Filament\Navigation\UserMenuItem;
use Filament\Pages;
use Filament\Panel;
use Filament\PanelProvider;
use Filament\Support\Colors\Color;
use Filament\Support\Facades\FilamentView;
use Filament\Tables\View\TablesRenderHook;
use Filament\View\PanelsRenderHook;
use Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse;
use Illuminate\Cookie\Middleware\EncryptCookies;
use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken;
use Illuminate\Routing\Middleware\SubstituteBindings;
use Illuminate\Session\Middleware\AuthenticateSession;
use Illuminate\Session\Middleware\StartSession;
use Illuminate\Support\HtmlString;
use Illuminate\View\Middleware\ShareErrorsFromSession;
use Jeffgreco13\FilamentBreezy\BreezyCore;
use Laravel\Socialite\Contracts\User as SocialiteUserContract;
use Rupadana\ApiService\ApiServicePlugin;

class AdminPanelProvider extends PanelProvider
{
    private ?KaidoSetting $settings = null;

    // constructor
    public function __construct()
    {
        // this is feels bad but this is the solution that i can think for now :D
        // Check if settings table exists first
        try {
            if (\Illuminate\Support\Facades\Schema::hasTable('settings')) {
                $this->settings = app(KaidoSetting::class);
            }
        } catch (\Exception $e) {
            $this->settings = null;
        }
    }

    public function boot(): void
    {
        // Sembunyikan header actions default (Export/Import) dari posisi aslinya
        FilamentView::registerRenderHook(
            TablesRenderHook::HEADER_BEFORE,
            fn (): HtmlString => new HtmlString('<style>.fi-ta-header-ctn>.fi-ta-header{display:none!important}</style>'),
            scopes: ListDevices::class,
        );

        // Inject tombol Export/Import ke dalam toolbar (sejajar search + filter + column toggle)
        FilamentView::registerRenderHook(
            TablesRenderHook::TOOLBAR_TOGGLE_COLUMN_TRIGGER_AFTER,
            fn () => view('filament.device-table-toolbar-actions'),
            scopes: ListDevices::class,
        );
    }

    public function panel(Panel $panel): Panel
    {
        return $panel
            ->default()
            ->id('admin')
            ->path('admin')
            ->when($this->settings->login_enabled ?? true, fn ($panel) => $panel->login(Login::class))
            ->when($this->settings->registration_enabled ?? true, fn ($panel) => $panel->registration(Register::class))
            ->when($this->settings->password_reset_enabled ?? true, fn ($panel) => $panel->passwordReset())
            ->when($this->settings->email_verification_required ?? false, fn ($panel) => $panel->emailVerification())
            ->colors([
                'primary' => Color::Amber,
            ])
            ->viteTheme('resources/css/filament/admin/theme.css')
            ->discoverResources(in: app_path('Filament/Modules'), for: 'App\\Filament\\Modules')
            ->discoverPages(in: app_path('Filament/Pages'), for: 'App\\Filament\\Pages')
            ->when(true, fn (Panel $panel): Panel => $this->discoverModulePages($panel))
            ->pages([
                Pages\Dashboard::class,
            ])
            ->discoverWidgets(in: app_path('Filament/Widgets'), for: 'App\\Filament\\Widgets')
            ->widgets([
                \App\Filament\Widgets\WelcomeMessageWidget::class,
            ])
            ->middleware([
                EncryptCookies::class,
                AddQueuedCookiesToResponse::class,
                StartSession::class,
                AuthenticateSession::class,
                ShareErrorsFromSession::class,
                VerifyCsrfToken::class,
                SubstituteBindings::class,
                DisableBladeIconComponents::class,
                DispatchServingFilamentEvent::class,
            ])
            ->sidebarCollapsibleOnDesktop(true)
            ->collapsibleNavigationGroups(true)
            ->authMiddleware([
                Authenticate::class,
                ApplyUserThemeColor::class,
            ])
            ->userMenuItems([
                UserMenuItem::make()
                    ->label('Tampilan Admin')
                    ->icon('heroicon-o-swatch')
                    ->url(fn () => ThemeColorPage::getUrl()),
            ])
            ->plugins(
                $this->getPlugins()
            )
            ->navigationGroups([
                NavigationGroup::make('IT Helpdesk')
                    ->icon('heroicon-o-ticket'),
                NavigationGroup::make('Kendaraan Dinas')
                    ->icon('heroicon-o-truck'),
                NavigationGroup::make('Inventaris')
                    ->icon('heroicon-o-computer-desktop'),
                NavigationGroup::make('Knowledge Management')
                    ->icon('heroicon-o-document-text'),
                NavigationGroup::make('Manajemen User')
                    ->icon('heroicon-o-users'),
                NavigationGroup::make('Pengaturan')
                    ->icon('heroicon-o-cog-6-tooth')
                    ->collapsed(),
            ])
            ->databaseNotifications()
            ->renderHook(
                PanelsRenderHook::BODY_START,
                fn (): string => view('filament.components.admin-ui-theme-classes')->render()
            )
            ->renderHook(
                PanelsRenderHook::USER_MENU_AFTER,
                fn (): string => view('filament.components.logout-button')->render()
            );
    }

    private function discoverModulePages(Panel $panel): Panel
    {
        foreach (glob(app_path('Filament/Modules/*/Pages'), GLOB_ONLYDIR) ?: [] as $directory) {
            $module = basename(dirname($directory));

            $panel->discoverPages(
                in: $directory,
                for: "App\\Filament\\Modules\\{$module}\\Pages",
            );
        }

        return $panel;
    }

    private function getPlugins(): array
    {
        $plugins = [
            FilamentShieldPlugin::make(),
            ApiServicePlugin::make(),
            BreezyCore::make()
                ->myProfile(
                    shouldRegisterUserMenu: true, // Sets the 'account' link in the panel User Menu (default = true)
                    shouldRegisterNavigation: false, // Keep profile in user menu only.
                    hasAvatars: true, // Enables the avatar upload form component (default = false)
                    slug: 'my-profile'
                )
                ->avatarUploadComponent(fn ($fileUpload) => $fileUpload->disableLabel())
                // OR, replace with your own component
                ->avatarUploadComponent(
                    fn () => FileUpload::make('avatar_url')
                        ->image()
                        ->disk('public')
                )
                ->enableTwoFactorAuthentication(),
        ];

        if ($this->settings->sso_enabled ?? true) {
            $plugins[] =
                FilamentSocialitePlugin::make()
                    ->providers([
                        Provider::make('google')
                            ->label('Google')
                            ->icon('fab-google')
                            ->color(Color::hex('#2f2a6b'))
                            ->outlined(true)
                            ->stateless(false),
                    ])->registration(true)
                    ->createUserUsing(function (string $provider, SocialiteUserContract $oauthUser, FilamentSocialitePlugin $plugin) {
                        // Find existing user by email
                        $user = User::where('email', $oauthUser->getEmail())->first();

                        if (! $user) {
                            // Generate temporary NIP for SSO users (starting with 0)
                            // Format: 0XXXXXXXX (9 digits, starts with 0 to indicate SSO user)
                            do {
                                $tempNip = '0'.str_pad(random_int(0, 99999999), 8, '0', STR_PAD_LEFT);
                            } while (User::where('nip', $tempNip)->exists());

                            $user = User::create([
                                'name' => $oauthUser->getName(),
                                'nip' => $tempNip,
                                'email' => $oauthUser->getEmail(),
                                'email_verified_at' => now(),
                            ]);
                        }

                        return $user;
                    });
        }

        return $plugins;
    }
}
