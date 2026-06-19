<?php

namespace App\Enums;

enum TicketStatus: string
{
    case Open = 'open';
    case InProgress = 'in_progress';
    case WaitingForUser = 'waiting_for_user';
    case Resolved = 'resolved';
    case Closed = 'closed';

    public function label(): string
    {
        return match ($this) {
            self::Open => 'Dibuka',
            self::InProgress => 'Diproses',
            self::WaitingForUser => 'Menunggu User',
            self::Resolved => 'Selesai',
            self::Closed => 'Ditutup',
        };
    }

    public function color(): string
    {
        return match ($this) {
            self::Open => 'danger',
            self::InProgress => 'warning',
            self::WaitingForUser => 'info',
            self::Resolved => 'success',
            self::Closed => 'gray',
        };
    }

    public static function openValues(): array
    {
        return [
            self::Open->value,
            self::InProgress->value,
            self::WaitingForUser->value,
        ];
    }

    public static function completedValues(): array
    {
        return [
            self::Resolved->value,
            self::Closed->value,
        ];
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (self $status) => [$status->value => $status->label()])
            ->all();
    }

    public static function values(): array
    {
        return array_column(self::cases(), 'value');
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
