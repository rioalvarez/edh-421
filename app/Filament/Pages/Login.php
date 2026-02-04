<?php

namespace App\Filament\Pages;

use DanHarrin\LivewireRateLimiting\Exceptions\TooManyRequestsException;
use Filament\Facades\Filament;
use Filament\Forms\Components\Component;
use Filament\Forms\Components\TextInput;
use Filament\Pages\Auth\Login as BaseLogin;
use Illuminate\Contracts\View\View;
use Filament\Http\Responses\Auth\Contracts\LoginResponse;
use Filament\Models\Contracts\FilamentUser;
use Illuminate\Validation\ValidationException;

class Login extends BaseLogin
{
    protected static string $view = 'filament.pages.login';

    public ?string $nipValidationStatus = null; // 'valid', 'invalid', or null
    public ?string $nipValidationMessage = null;

    public function authenticate(): ?LoginResponse
    {
        try {
            $this->rateLimit(5);
        } catch (TooManyRequestsException $exception) {
            $this->getRateLimitedNotification($exception)?->send();

            return null;
        }

        $data = $this->form->getState();

        // Check if user exists
        $user = \App\Models\User::where('nip', $data['nip'])->first();

        // Validasi 1: NIP tidak terdaftar
        if (!$user) {
            throw ValidationException::withMessages([
                'data.nip' => 'NIP tidak terdaftar dalam sistem.',
            ]);
        }

        // Validasi 2: User dibuat melalui social login (password null)
        if (is_null($user->password)) {
            throw ValidationException::withMessages([
                'data.nip' => 'Akun ini dibuat melalui social login. Silakan login dengan Google.',
            ]);
        }

        // Validasi 3: Password tidak sesuai
        if (! Filament::auth()->attempt($this->getCredentialsFromFormData($data), $data['remember'] ?? false)) {
            throw ValidationException::withMessages([
                'data.password' => 'Password tidak sesuai.',
            ]);
        }

        $user = Filament::auth()->user();

        if (
            ($user instanceof FilamentUser) &&
            (! $user->canAccessPanel(Filament::getCurrentPanel()))
        ) {
            Filament::auth()->logout();

            $this->throwFailureValidationException();
        }

        session()->regenerate();

        return app(LoginResponse::class);
    }

    public function mount(): void
    {
        parent::mount();

        // Reset validation status
        $this->nipValidationStatus = null;
        $this->nipValidationMessage = null;

        // Only pre-fill credentials in local development environment
        if (app()->environment('local')) {
            $this->form->fill([
                'nip' => '123456789',
                'password' => 'password',
                'remember' => true,
            ]);

            // Validate pre-filled NIP
            $this->validateNipRealtime('123456789');
        }
    }

    /**
     * @return array<int | string, string | Form>
     */
    protected function getForms(): array
    {
        return [
            'form' => $this->form(
                $this->makeForm()
                    ->schema([
                        $this->getNipFormComponent(),
                        $this->getPasswordFormComponent(),
                        $this->getRememberFormComponent(),
                    ])
                    ->statePath('data'),
            ),
        ];
    }

    protected function getNipFormComponent(): Component
    {
        return TextInput::make('nip')
            ->label('NIP')
            ->placeholder('Masukkan 9 digit NIP')
            ->required()
            ->numeric()
            ->minLength(9)
            ->maxLength(9)
            ->autocomplete('username')
            ->autofocus()
            ->extraInputAttributes(['inputmode' => 'numeric'])
            ->live(debounce: 500)
            ->afterStateUpdated(function (?string $state) {
                $this->validateNipRealtime($state);
            })
            ->hint(fn () => $this->nipValidationMessage)
            ->hintColor(fn () => $this->nipValidationStatus === 'valid' ? 'success' : 'danger');
    }

    protected function validateNipRealtime(?string $nip): void
    {
        // Reset jika input kosong atau belum 9 digit
        if (empty($nip) || strlen($nip) < 9) {
            $this->nipValidationStatus = null;
            $this->nipValidationMessage = null;
            return;
        }

        // Cek apakah NIP terdaftar di database
        $user = \App\Models\User::where('nip', $nip)->first();

        if ($user) {
            $this->nipValidationStatus = 'valid';
            $this->nipValidationMessage = '✓ NIP terdaftar: ' . $user->name;
        } else {
            $this->nipValidationStatus = 'invalid';
            $this->nipValidationMessage = '✗ NIP tidak terdaftar dalam sistem';
        }
    }

    protected function getCredentialsFromFormData(array $data): array
    {
        return [
            'nip' => $data['nip'],
            'password' => $data['password'],
        ];
    }

    protected function throwFailureValidationException(): never
    {
        throw ValidationException::withMessages([
            'data.nip' => __('filament-panels::pages/auth/login.messages.failed'),
        ]);
    }
}
