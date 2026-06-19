<?php

namespace App\Enums;

enum VehicleFuelType: string
{
    case Bensin = 'bensin';
    case Solar = 'solar';
    case Listrik = 'listrik';

    public function label(): string
    {
        return match ($this) {
            self::Bensin => 'Bensin',
            self::Solar => 'Solar',
            self::Listrik => 'Listrik',
        };
    }

    public function color(): string
    {
        return match ($this) {
            self::Bensin => 'success',
            self::Solar => 'warning',
            self::Listrik => 'info',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (self $type) => [$type->value => $type->label()])
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
