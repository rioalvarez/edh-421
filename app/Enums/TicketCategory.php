<?php

namespace App\Enums;

enum TicketCategory: string
{
    case IncidentManagement = 'incident_management';
    case ServiceRequest = 'service_request';
    case UserSupport = 'user_support';
    case AccessManagement = 'access_management';
    case AssetManagement = 'asset_management';
    case ChangeManagement = 'change_management';
    case NetworkSupport = 'network_support';
    case SecuritySupport = 'security_support';
    case DocumentationKb = 'documentation_kb';
    case Hardware = 'hardware';
    case Software = 'software';
    case Network = 'network';
    case Printer = 'printer';
    case Other = 'other';

    public function label(): string
    {
        return match ($this) {
            self::IncidentManagement => 'Manajemen Insiden',
            self::ServiceRequest => 'Permintaan Layanan',
            self::UserSupport => 'Dukungan User',
            self::AccessManagement => 'Manajemen Akses',
            self::AssetManagement => 'Manajemen Aset',
            self::ChangeManagement => 'Manajemen Perubahan',
            self::NetworkSupport => 'Dukungan Jaringan',
            self::SecuritySupport => 'Dukungan Keamanan',
            self::DocumentationKb => 'Dokumentasi & Basis Pengetahuan',
            self::Hardware => 'Hardware',
            self::Software => 'Software',
            self::Network => 'Jaringan',
            self::Printer => 'Printer',
            self::Other => 'Lainnya',
        };
    }

    public function color(): string
    {
        return match ($this) {
            self::IncidentManagement, self::SecuritySupport => 'danger',
            self::ServiceRequest, self::NetworkSupport => 'info',
            self::UserSupport => 'success',
            self::AccessManagement, self::ChangeManagement => 'warning',
            self::AssetManagement => 'primary',
            self::DocumentationKb => 'gray',
            default => 'gray',
        };
    }

    public static function serviceOptions(): array
    {
        return collect([
            self::IncidentManagement,
            self::ServiceRequest,
            self::UserSupport,
            self::AccessManagement,
            self::AssetManagement,
            self::ChangeManagement,
            self::NetworkSupport,
            self::SecuritySupport,
            self::DocumentationKb,
        ])->mapWithKeys(fn (self $category) => [$category->value => $category->label()])
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
