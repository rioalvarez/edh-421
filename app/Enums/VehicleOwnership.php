<?php

namespace App\Enums;

enum VehicleOwnership: string
{
    case Dinas = 'dinas';
    case Sewa = 'sewa';

    public function label(): string
    {
        return match ($this) {
            self::Dinas => 'Kendaraan Dinas',
            self::Sewa => 'Kendaraan Sewa',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (self $ownership) => [$ownership->value => $ownership->label()])
            ->all();
    }

    public static function tryLabel(?string $value): ?string
    {
        return self::tryFrom((string) $value)?->label() ?? $value;
    }
}
