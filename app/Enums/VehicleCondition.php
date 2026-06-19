<?php

namespace App\Enums;

enum VehicleCondition: string
{
    case Excellent = 'excellent';
    case Good = 'good';
    case Fair = 'fair';
    case Poor = 'poor';

    public function label(): string
    {
        return match ($this) {
            self::Excellent => 'Sangat Baik',
            self::Good => 'Baik',
            self::Fair => 'Cukup',
            self::Poor => 'Buruk',
        };
    }

    public function color(): string
    {
        return match ($this) {
            self::Excellent => 'success',
            self::Good => 'info',
            self::Fair => 'warning',
            self::Poor => 'danger',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (self $condition) => [$condition->value => $condition->label()])
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
