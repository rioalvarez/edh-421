<?php

namespace App\Enums;

enum VehicleBookingStatus: string
{
    case Approved = 'approved';
    case InUse = 'in_use';
    case Completed = 'completed';
    case Cancelled = 'cancelled';

    public function label(): string
    {
        return match ($this) {
            self::Approved => 'Disetujui',
            self::InUse => 'Sedang Digunakan',
            self::Completed => 'Selesai',
            self::Cancelled => 'Dibatalkan',
        };
    }

    public function color(): string
    {
        return match ($this) {
            self::Approved => 'info',
            self::InUse => 'warning',
            self::Completed => 'success',
            self::Cancelled => 'danger',
        };
    }

    public static function activeValues(): array
    {
        return [self::Approved->value, self::InUse->value];
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (self $status) => [$status->value => $status->label()])
            ->all();
    }

    public static function tryLabel(?string $value): ?string
    {
        return self::tryFrom((string) $value)?->label() ?? $value;
    }

    public static function tryColor(?string $value): string
    {
        return self::tryFrom((string) $value)?->color() ?? 'gray';
    }
}
