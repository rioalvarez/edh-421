<?php

namespace App\Enums;

enum VehicleStatus: string
{
    case Available = 'available';
    case InUse = 'in_use';
    case Maintenance = 'maintenance';
    case Retired = 'retired';

    public function label(): string
    {
        return match ($this) {
            self::Available => 'Tersedia',
            self::InUse => 'Digunakan',
            self::Maintenance => 'Perbaikan',
            self::Retired => 'Tidak Aktif',
        };
    }

    public function color(): string
    {
        return match ($this) {
            self::Available => 'success',
            self::InUse => 'warning',
            self::Maintenance => 'info',
            self::Retired => 'gray',
        };
    }

    public static function activeValues(): array
    {
        return [self::Available->value, self::InUse->value];
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
