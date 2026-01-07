<?php

namespace App\Filament\Pages;

use App\Models\User;
use Filament\Forms\Components\Component;
use Filament\Forms\Components\TextInput;
use Filament\Pages\Auth\Register as BaseRegister;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules\Password;

class Register extends BaseRegister
{
    protected function getForms(): array
    {
        return [
            'form' => $this->form(
                $this->makeForm()
                    ->schema([
                        $this->getNameFormComponent(),
                        $this->getNipFormComponent(),
                        $this->getPhoneFormComponent(),
                        $this->getEmailFormComponent(),
                        $this->getPasswordFormComponent(),
                        $this->getPasswordConfirmationFormComponent(),
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
            ->unique(User::class)
            ->validationMessages([
                'unique' => 'NIP sudah terdaftar.',
                'min' => 'NIP harus 9 digit.',
                'max' => 'NIP harus 9 digit.',
            ])
            ->extraInputAttributes(['inputmode' => 'numeric']);
    }

    protected function getPhoneFormComponent(): Component
    {
        return TextInput::make('phone_number')
            ->label('No. HP')
            ->placeholder('Contoh: 08123456789')
            ->tel()
            ->maxLength(20);
    }

    protected function getEmailFormComponent(): Component
    {
        return TextInput::make('email')
            ->label('Email (Opsional)')
            ->placeholder('email@domain.com')
            ->email()
            ->maxLength(255)
            ->unique(User::class);
    }

    protected function getPasswordFormComponent(): Component
    {
        return TextInput::make('password')
            ->label('Password')
            ->password()
            ->revealable(filament()->arePasswordsRevealable())
            ->required()
            ->rule(Password::default())
            ->dehydrateStateUsing(fn($state) => Hash::make($state))
            ->same('passwordConfirmation')
            ->validationAttribute('password');
    }

    protected function getPasswordConfirmationFormComponent(): Component
    {
        return TextInput::make('passwordConfirmation')
            ->label('Konfirmasi Password')
            ->password()
            ->revealable(filament()->arePasswordsRevealable())
            ->required()
            ->dehydrated(false);
    }
}
