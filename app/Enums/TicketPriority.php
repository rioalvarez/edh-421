<?php

namespace App\Enums;

use App\Settings\SlaSettings;

enum TicketPriority: string
{
    case Critical = 'critical';
    case High = 'high';
    case Medium = 'medium';
    case Low = 'low';

    public function label(): string
    {
        return match ($this) {
            self::Critical => 'Kritis',
            self::High => 'Tinggi',
            self::Medium => 'Sedang',
            self::Low => 'Rendah',
        };
    }

    public function color(): string
    {
        return match ($this) {
            self::Critical => 'danger',
            self::High => 'warning',
            self::Medium => 'info',
            self::Low => 'gray',
        };
    }

    public function slaHours(SlaSettings $settings): int
    {
        return match ($this) {
            self::Critical => $settings->critical_hours,
            self::High => $settings->high_hours,
            self::Medium => $settings->medium_hours,
            self::Low => $settings->low_hours,
        };
    }

    public static function options(bool $includeCritical = true): array
    {
        return collect(self::cases())
            ->when(! $includeCritical, fn ($priorities) => $priorities->reject(fn (self $priority) => $priority === self::Critical))
            ->mapWithKeys(fn (self $priority) => [$priority->value => $priority->label()])
            ->all();
    }

    public static function highValues(): array
    {
        return [
            self::High->value,
            self::Critical->value,
        ];
    }

    public static function orderValues(): array
    {
        return [
            self::Critical->value,
            self::High->value,
            self::Medium->value,
            self::Low->value,
        ];
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
