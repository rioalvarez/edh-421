<?php

namespace App\Enums;

enum FuelLevel: string
{
    case Empty = 'empty';
    case Quarter = 'quarter';
    case Half = 'half';
    case ThreeQuarter = 'three_quarter';
    case Full = 'full';

    public function label(): string
    {
        return match ($this) {
            self::Empty => 'Kosong (E)',
            self::Quarter => '1/4',
            self::Half => '1/2',
            self::ThreeQuarter => '3/4',
            self::Full => 'Penuh (F)',
        };
    }

    public function color(): string
    {
        return match ($this) {
            self::Empty => 'danger',
            self::Quarter => 'warning',
            self::Half => 'info',
            self::ThreeQuarter, self::Full => 'success',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (self $level) => [$level->value => $level->label()])
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
