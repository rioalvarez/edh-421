<?php

namespace App\Models;

use Filament\Models\Contracts\FilamentUser;
use Filament\Models\Contracts\HasAvatar;
use Filament\Panel;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Storage;
use Jeffgreco13\FilamentBreezy\Traits\TwoFactorAuthenticatable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable implements FilamentUser, HasAvatar, MustVerifyEmail
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasApiTokens, HasFactory, HasRoles, Notifiable, TwoFactorAuthenticatable;

    public const ROLE_SUPER_ADMIN = 'super_admin';

    public const ROLE_ADMIN = 'Admin';

    public const ROLE_MEMBER = 'Member';

    public const IT_ADMIN_ROLES = [
        self::ROLE_SUPER_ADMIN,
        self::ROLE_ADMIN,
    ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'nip',
        'email',
        'phone_number',
        'password',
        'avatar_url',
        'theme_color',
        'theme_gray',
        'theme_gray_level',
        'theme_sidebar_style',
        'theme_navbar_style',
        'theme_density',
        'theme_radius',
        'theme_content_width',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    // public function getFilamentAvatarUrl(): ?string
    // {
    //     return asset($this->avatar_url);
    // }

    public function getFilamentAvatarUrl(): ?string
    {
        return $this->avatar_url ? Storage::url($this->avatar_url) : null;
    }

    /**
     * Override: user tanpa email dianggap sudah terverifikasi
     * (tidak ada email yang perlu diverifikasi).
     */
    public function hasVerifiedEmail(): bool
    {
        if (is_null($this->email)) {
            return true;
        }

        return ! is_null($this->email_verified_at);
    }

    public function canAccessPanel(Panel $panel): bool
    {
        return true;
    }

    public function isSuperAdmin(): bool
    {
        return $this->hasRole(self::ROLE_SUPER_ADMIN);
    }

    public function isItAdmin(): bool
    {
        return $this->hasAnyRole(self::IT_ADMIN_ROLES);
    }

    public static function itAdmins()
    {
        $roles = Role::query()
            ->whereIn('name', self::IT_ADMIN_ROLES)
            ->pluck('name')
            ->all();

        if ($roles === []) {
            return static::query()->whereRaw('1 = 0');
        }

        return static::role($roles);
    }

    public function device(): HasOne
    {
        return $this->hasOne(Device::class);
    }

    public function tickets(): HasMany
    {
        return $this->hasMany(Ticket::class);
    }

    public function assignedTickets(): HasMany
    {
        return $this->hasMany(Ticket::class, 'assigned_to');
    }
}
