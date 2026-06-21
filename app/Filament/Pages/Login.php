<?php

namespace App\Filament\Pages;

use DanHarrin\LivewireRateLimiting\Exceptions\TooManyRequestsException;
use Filament\Facades\Filament;
use Filament\Forms\Components\Component;
use Filament\Forms\Components\TextInput;
use Filament\Http\Responses\Auth\Contracts\LoginResponse;
use Filament\Models\Contracts\FilamentUser;
use Filament\Pages\Auth\Login as BaseLogin;
use Illuminate\Validation\ValidationException;

class Login extends BaseLogin
{
    protected static string $view = 'filament.pages.login';

    public function authenticate(): ?LoginResponse
    {
        try {
            $this->rateLimit(5);
        } catch (TooManyRequestsException $exception) {
            $this->getRateLimitedNotification($exception)?->send();

            return null;
        }

        $data = $this->form->getState();

        $user = \App\Models\User::where('nip', $data['nip'])->first();

        // Validasi: NIP tidak terdaftar atau password salah — pesan generik untuk keamanan
        if (! $user) {
            throw ValidationException::withMessages([
                'data.nip' => 'NIP atau password tidak sesuai.',
            ]);
        }

        // Validasi: User SSO-only (password null)
        if (is_null($user->password)) {
            throw ValidationException::withMessages([
                'data.nip' => 'Akun ini terdaftar melalui Google SSO. Silakan gunakan tombol "Login dengan Google" di bawah.',
            ]);
        }

        // Validasi: Password tidak sesuai — pesan generik
        if (! Filament::auth()->attempt($this->getCredentialsFromFormData($data), $data['remember'] ?? false)) {
            throw ValidationException::withMessages([
                'data.nip' => 'NIP atau password tidak sesuai.',
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
            ->extraInputAttributes(['inputmode' => 'numeric']);
    }

    protected function getPasswordFormComponent(): Component
    {
        return TextInput::make('password')
            ->label('Password')
            ->placeholder('Masukkan password')
            ->password()
            ->revealable()
            ->required()
            ->autocomplete('current-password');
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
