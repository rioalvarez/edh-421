<?php

namespace App\Enums;

enum DeviceType: string
{
    case Laptop = 'laptop';
    case Desktop = 'desktop';
    case AllInOne = 'all-in-one';
    case Workstation = 'workstation';
    case Printer = 'printer';
    case Scanner = 'scanner';
    case Router = 'router';
    case Switch = 'switch';
    case AccessPoint = 'access-point';
    case Other = 'other';

    public function label(): string
    {
        return match ($this) {
            self::Laptop => 'Laptop',
            self::Desktop => 'Desktop',
            self::AllInOne => 'All-in-One',
            self::Workstation => 'Workstation',
            self::Printer => 'Printer',
            self::Scanner => 'Scanner',
            self::Router => 'Router',
            self::Switch => 'Switch',
            self::AccessPoint => 'Access Point',
            self::Other => 'Lainnya',
        };
    }

    public function color(): string
    {
        return match ($this) {
            self::Laptop, self::Desktop, self::AllInOne, self::Workstation => 'info',
            self::Printer, self::Scanner => 'warning',
            self::Router, self::Switch, self::AccessPoint => 'success',
            self::Other => 'gray',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (self $type) => [$type->value => $type->label()])
            ->all();
    }

    /**
     * Opsi ber-grup untuk Select form (Komputer, Printer/Scanner, Jaringan, Lainnya).
     */
    public static function groupedOptions(): array
    {
        $toOptions = fn (array $values) => collect($values)
            ->mapWithKeys(fn (string $value) => [$value => self::from($value)->label()])
            ->all();

        return [
            'Komputer' => $toOptions(self::computerValues()),
            'Printer / Scanner' => $toOptions(self::printerValues()),
            'Perangkat Jaringan' => $toOptions(self::networkValues()),
            'Lainnya' => [self::Other->value => self::Other->label()],
        ];
    }

    public static function computerValues(): array
    {
        return [self::Laptop->value, self::Desktop->value, self::AllInOne->value, self::Workstation->value];
    }

    public static function printerValues(): array
    {
        return [self::Printer->value, self::Scanner->value];
    }

    public static function networkValues(): array
    {
        return [self::Router->value, self::Switch->value, self::AccessPoint->value];
    }

    public static function networkCapableValues(): array
    {
        return [...self::computerValues(), ...self::printerValues(), ...self::networkValues()];
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
