<?php

use App\Enums\TicketStatus;
use App\Filament\Modules\Helpdesk\Resources\TicketResource\Support\TicketDeviceOptions;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Support\VehicleBookingFormSupport;
use App\Models\Device;
use App\Models\Ticket;
use App\Models\User;
use App\Models\Vehicle;
use App\Services\Helpdesk\TicketReportService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Spatie\Permission\Models\Role;

uses(RefreshDatabase::class);

beforeEach(function () {
    Role::firstOrCreate(['name' => 'super_admin', 'guard_name' => 'web']);
    $this->user = User::factory()->create();
});

it('builds ticket report statistics from enum-backed statuses', function () {
    Ticket::create([
        'ticket_number' => 'TKT-REPORT-0001',
        'user_id' => $this->user->id,
        'subject' => 'Open ticket',
        'description' => 'Need support',
        'priority' => 'medium',
        'status' => TicketStatus::Open->value,
        'category' => 'hardware',
        'created_at' => now()->subDay(),
        'updated_at' => now()->subDay(),
    ]);

    Ticket::create([
        'ticket_number' => 'TKT-REPORT-0002',
        'user_id' => $this->user->id,
        'subject' => 'Resolved ticket',
        'description' => 'Done',
        'priority' => 'high',
        'status' => TicketStatus::Resolved->value,
        'category' => 'software',
        'resolved_at' => now(),
        'created_at' => now()->subHours(2),
        'updated_at' => now(),
    ]);

    $service = app(TicketReportService::class);
    $stats = $service->statistics(now()->subDays(2)->format('Y-m-d'), now()->format('Y-m-d'));

    expect($stats['total'])->toBe(2)
        ->and($stats['open'])->toBe(1)
        ->and($stats['resolved'])->toBe(1)
        ->and($stats['resolution_rate'])->toBe(50.0)
        ->and($service->statusLabel(TicketStatus::Resolved->value))->toBe('Selesai');
});

it('builds grouped device options without loading unbounded device lists', function () {
    Device::create([
        'user_id' => $this->user->id,
        'type' => 'desktop',
        'hostname' => 'PC-USER',
        'condition' => 'good',
        'status' => 'active',
    ]);

    Device::create([
        'type' => 'desktop',
        'hostname' => 'PC-SHARED',
        'condition' => 'good',
        'status' => 'active',
    ]);

    $options = TicketDeviceOptions::forUser($this->user->id);

    expect($options)->toHaveKey('Perangkat Saya')
        ->and($options)->toHaveKey('Perangkat Bersama')
        ->and(array_values($options['Perangkat Saya'])[0])->toContain('PC-USER')
        ->and(array_values($options['Perangkat Bersama'])[0])->toContain('PC-SHARED');
});

it('renders vehicle availability message for available booking dates', function () {
    $vehicle = Vehicle::create([
        'brand' => 'Toyota',
        'model' => 'Avanza',
        'plate_number' => 'B 1234 ABC',
        'status' => 'available',
        'condition' => 'good',
        'fuel_type' => 'bensin',
        'ownership' => 'dinas',
    ]);

    $html = VehicleBookingFormSupport::availabilityStatus(
        $vehicle->id,
        now()->addDay()->format('Y-m-d'),
        now()->addDays(2)->format('Y-m-d'),
    )->toHtml();

    expect($html)->toContain('Tersedia!')
        ->and($html)->toContain('B 1234 ABC');
});
