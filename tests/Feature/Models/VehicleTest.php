<?php

use App\Models\Vehicle;
use App\Models\VehicleBooking;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Spatie\Permission\Models\Role;
use Carbon\Carbon;

uses(RefreshDatabase::class);

beforeEach(function () {
    // Create super_admin role for VehicleBookingObserver
    Role::firstOrCreate(['name' => 'super_admin', 'guard_name' => 'web']);

    $this->user = User::factory()->create();
});

describe('Vehicle Model', function () {

    describe('Display Name Accessor', function () {

        it('returns formatted display name with brand model and plate number', function () {
            $vehicle = new Vehicle([
                'brand' => 'Toyota',
                'model' => 'Avanza',
                'plate_number' => 'B 1234 ABC',
            ]);

            expect($vehicle->display_name)->toBe('Toyota Avanza (B 1234 ABC)');
        });
    });

    describe('Status Label Accessor', function () {

        it('returns Tersedia for available status', function () {
            $vehicle = new Vehicle(['status' => 'available']);
            expect($vehicle->status_label)->toBe('Tersedia');
        });

        it('returns Digunakan for in_use status', function () {
            $vehicle = new Vehicle(['status' => 'in_use']);
            expect($vehicle->status_label)->toBe('Digunakan');
        });

        it('returns Perbaikan for maintenance status', function () {
            $vehicle = new Vehicle(['status' => 'maintenance']);
            expect($vehicle->status_label)->toBe('Perbaikan');
        });

        it('returns Tidak Aktif for retired status', function () {
            $vehicle = new Vehicle(['status' => 'retired']);
            expect($vehicle->status_label)->toBe('Tidak Aktif');
        });
    });

    describe('Status Color Accessor', function () {

        it('returns success for available status', function () {
            $vehicle = new Vehicle(['status' => 'available']);
            expect($vehicle->status_color)->toBe('success');
        });

        it('returns warning for in_use status', function () {
            $vehicle = new Vehicle(['status' => 'in_use']);
            expect($vehicle->status_color)->toBe('warning');
        });

        it('returns info for maintenance status', function () {
            $vehicle = new Vehicle(['status' => 'maintenance']);
            expect($vehicle->status_color)->toBe('info');
        });

        it('returns gray for retired status', function () {
            $vehicle = new Vehicle(['status' => 'retired']);
            expect($vehicle->status_color)->toBe('gray');
        });
    });

    describe('Condition Label Accessor', function () {

        it('returns Sangat Baik for excellent condition', function () {
            $vehicle = new Vehicle(['condition' => 'excellent']);
            expect($vehicle->condition_label)->toBe('Sangat Baik');
        });

        it('returns Baik for good condition', function () {
            $vehicle = new Vehicle(['condition' => 'good']);
            expect($vehicle->condition_label)->toBe('Baik');
        });

        it('returns Cukup for fair condition', function () {
            $vehicle = new Vehicle(['condition' => 'fair']);
            expect($vehicle->condition_label)->toBe('Cukup');
        });

        it('returns Buruk for poor condition', function () {
            $vehicle = new Vehicle(['condition' => 'poor']);
            expect($vehicle->condition_label)->toBe('Buruk');
        });
    });

    describe('Condition Color Accessor', function () {

        it('returns success for excellent condition', function () {
            $vehicle = new Vehicle(['condition' => 'excellent']);
            expect($vehicle->condition_color)->toBe('success');
        });

        it('returns info for good condition', function () {
            $vehicle = new Vehicle(['condition' => 'good']);
            expect($vehicle->condition_color)->toBe('info');
        });

        it('returns warning for fair condition', function () {
            $vehicle = new Vehicle(['condition' => 'fair']);
            expect($vehicle->condition_color)->toBe('warning');
        });

        it('returns danger for poor condition', function () {
            $vehicle = new Vehicle(['condition' => 'poor']);
            expect($vehicle->condition_color)->toBe('danger');
        });
    });

    describe('Fuel Type Label Accessor', function () {

        it('returns Bensin for bensin fuel type', function () {
            $vehicle = new Vehicle(['fuel_type' => 'bensin']);
            expect($vehicle->fuel_type_label)->toBe('Bensin');
        });

        it('returns Solar for solar fuel type', function () {
            $vehicle = new Vehicle(['fuel_type' => 'solar']);
            expect($vehicle->fuel_type_label)->toBe('Solar');
        });

        it('returns Listrik for listrik fuel type', function () {
            $vehicle = new Vehicle(['fuel_type' => 'listrik']);
            expect($vehicle->fuel_type_label)->toBe('Listrik');
        });
    });

    describe('Ownership Label Accessor', function () {

        it('returns Kendaraan Dinas for dinas ownership', function () {
            $vehicle = new Vehicle(['ownership' => 'dinas']);
            expect($vehicle->ownership_label)->toBe('Kendaraan Dinas');
        });

        it('returns Kendaraan Sewa for sewa ownership', function () {
            $vehicle = new Vehicle(['ownership' => 'sewa']);
            expect($vehicle->ownership_label)->toBe('Kendaraan Sewa');
        });
    });

    describe('Helper Methods', function () {

        it('isAvailable returns true when status is available', function () {
            $vehicle = new Vehicle(['status' => 'available']);
            expect($vehicle->isAvailable())->toBeTrue();
        });

        it('isAvailable returns false when status is not available', function () {
            $vehicle = new Vehicle(['status' => 'in_use']);
            expect($vehicle->isAvailable())->toBeFalse();

            $vehicle->status = 'maintenance';
            expect($vehicle->isAvailable())->toBeFalse();

            $vehicle->status = 'retired';
            expect($vehicle->isAvailable())->toBeFalse();
        });

        it('isTaxExpired returns true when tax_expiry_date is in the past', function () {
            $vehicle = new Vehicle([
                'tax_expiry_date' => Carbon::yesterday(),
            ]);
            expect($vehicle->isTaxExpired())->toBeTrue();
        });

        it('isTaxExpired returns false when tax_expiry_date is in the future', function () {
            $vehicle = new Vehicle([
                'tax_expiry_date' => Carbon::tomorrow(),
            ]);
            expect($vehicle->isTaxExpired())->toBeFalse();
        });

        it('isTaxExpired returns false when tax_expiry_date is null', function () {
            $vehicle = new Vehicle(['tax_expiry_date' => null]);
            expect($vehicle->isTaxExpired())->toBeFalse();
        });

        it('isInspectionExpired returns true when inspection_expiry_date is in the past', function () {
            $vehicle = new Vehicle([
                'inspection_expiry_date' => Carbon::yesterday(),
            ]);
            expect($vehicle->isInspectionExpired())->toBeTrue();
        });

        it('isInspectionExpired returns false when inspection_expiry_date is in the future', function () {
            $vehicle = new Vehicle([
                'inspection_expiry_date' => Carbon::tomorrow(),
            ]);
            expect($vehicle->isInspectionExpired())->toBeFalse();
        });

        it('isInspectionExpired returns false when inspection_expiry_date is null', function () {
            $vehicle = new Vehicle(['inspection_expiry_date' => null]);
            expect($vehicle->isInspectionExpired())->toBeFalse();
        });
    });

    describe('Tax Expiry Warning Accessor', function () {

        it('returns true when tax expires within 30 days', function () {
            $vehicle = Vehicle::create([
                'brand' => 'Test',
                'model' => 'Car',
                'plate_number' => 'B 9999 ZZZ',
                'status' => 'available',
                'condition' => 'good',
                'fuel_type' => 'bensin',
                'ownership' => 'dinas',
                'tax_expiry_date' => Carbon::now()->addDays(15),
            ]);
            expect($vehicle->tax_expiry_warning)->toBeTrue();
        });

        it('returns false when tax expires in more than 30 days', function () {
            $vehicle = Vehicle::create([
                'brand' => 'Test',
                'model' => 'Car',
                'plate_number' => 'B 8888 YYY',
                'status' => 'available',
                'condition' => 'good',
                'fuel_type' => 'bensin',
                'ownership' => 'dinas',
                'tax_expiry_date' => Carbon::now()->addDays(60),
            ]);
            expect($vehicle->tax_expiry_warning)->toBeFalse();
        });

        it('returns false when tax is already expired', function () {
            $vehicle = Vehicle::create([
                'brand' => 'Test',
                'model' => 'Car',
                'plate_number' => 'B 7777 XXX',
                'status' => 'available',
                'condition' => 'good',
                'fuel_type' => 'bensin',
                'ownership' => 'dinas',
                'tax_expiry_date' => Carbon::yesterday(),
            ]);
            expect($vehicle->tax_expiry_warning)->toBeFalse();
        });

        it('returns false when tax_expiry_date is null', function () {
            $vehicle = Vehicle::create([
                'brand' => 'Test',
                'model' => 'Car',
                'plate_number' => 'B 6666 WWW',
                'status' => 'available',
                'condition' => 'good',
                'fuel_type' => 'bensin',
                'ownership' => 'dinas',
                'tax_expiry_date' => null,
            ]);
            expect($vehicle->tax_expiry_warning)->toBeFalse();
        });
    });

    describe('Inspection Expiry Warning Accessor', function () {

        it('returns true when inspection expires within 30 days', function () {
            $vehicle = Vehicle::create([
                'brand' => 'Test',
                'model' => 'Car',
                'plate_number' => 'B 5555 VVV',
                'status' => 'available',
                'condition' => 'good',
                'fuel_type' => 'bensin',
                'ownership' => 'dinas',
                'inspection_expiry_date' => Carbon::now()->addDays(15),
            ]);
            expect($vehicle->inspection_expiry_warning)->toBeTrue();
        });

        it('returns false when inspection expires in more than 30 days', function () {
            $vehicle = Vehicle::create([
                'brand' => 'Test',
                'model' => 'Car',
                'plate_number' => 'B 4444 UUU',
                'status' => 'available',
                'condition' => 'good',
                'fuel_type' => 'bensin',
                'ownership' => 'dinas',
                'inspection_expiry_date' => Carbon::now()->addDays(60),
            ]);
            expect($vehicle->inspection_expiry_warning)->toBeFalse();
        });

        it('returns false when inspection is already expired', function () {
            $vehicle = Vehicle::create([
                'brand' => 'Test',
                'model' => 'Car',
                'plate_number' => 'B 3333 TTT',
                'status' => 'available',
                'condition' => 'good',
                'fuel_type' => 'bensin',
                'ownership' => 'dinas',
                'inspection_expiry_date' => Carbon::yesterday(),
            ]);
            expect($vehicle->inspection_expiry_warning)->toBeFalse();
        });
    });

    describe('Scopes', function () {

        beforeEach(function () {
            Vehicle::create([
                'brand' => 'Toyota',
                'model' => 'Avanza',
                'plate_number' => 'B 1111 AAA',
                'status' => 'available',
                'condition' => 'good',
                'fuel_type' => 'bensin',
                'ownership' => 'dinas',
            ]);
            Vehicle::create([
                'brand' => 'Honda',
                'model' => 'Brio',
                'plate_number' => 'B 2222 BBB',
                'status' => 'in_use',
                'condition' => 'good',
                'fuel_type' => 'bensin',
                'ownership' => 'dinas',
            ]);
            Vehicle::create([
                'brand' => 'Suzuki',
                'model' => 'Ertiga',
                'plate_number' => 'B 3333 CCC',
                'status' => 'maintenance',
                'condition' => 'fair',
                'fuel_type' => 'bensin',
                'ownership' => 'sewa',
            ]);
            Vehicle::create([
                'brand' => 'Daihatsu',
                'model' => 'Xenia',
                'plate_number' => 'B 4444 DDD',
                'status' => 'retired',
                'condition' => 'poor',
                'fuel_type' => 'bensin',
                'ownership' => 'dinas',
            ]);
        });

        it('available scope returns only available vehicles', function () {
            $vehicles = Vehicle::available()->get();
            expect($vehicles)->toHaveCount(1);
            expect($vehicles->first()->plate_number)->toBe('B 1111 AAA');
        });

        it('active scope returns available and in_use vehicles', function () {
            $vehicles = Vehicle::active()->get();
            expect($vehicles)->toHaveCount(2);
            expect($vehicles->pluck('status')->toArray())->toContain('available', 'in_use');
        });
    });

    describe('Date Availability Check', function () {

        beforeEach(function () {
            $this->vehicle = Vehicle::create([
                'brand' => 'Toyota',
                'model' => 'Avanza',
                'plate_number' => 'B 1234 ABC',
                'status' => 'available',
                'condition' => 'good',
                'fuel_type' => 'bensin',
                'ownership' => 'dinas',
            ]);
        });

        it('returns true when no conflicting bookings exist', function () {
            $isAvailable = $this->vehicle->isAvailableForDates(
                Carbon::now()->addDays(5)->format('Y-m-d'),
                Carbon::now()->addDays(10)->format('Y-m-d')
            );
            expect($isAvailable)->toBeTrue();
        });

        it('returns false when booking dates overlap', function () {
            // Create an existing booking
            VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'booking_number' => 'KDO-TEST-0001',
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::now()->addDays(5),
                'end_date' => Carbon::now()->addDays(10),
                'status' => 'approved',
            ]);

            // Try to book overlapping dates
            $isAvailable = $this->vehicle->isAvailableForDates(
                Carbon::now()->addDays(7)->format('Y-m-d'),
                Carbon::now()->addDays(12)->format('Y-m-d')
            );
            expect($isAvailable)->toBeFalse();
        });

        it('excludes specified booking id from conflict check', function () {
            $booking = VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'booking_number' => 'KDO-TEST-0001',
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::now()->addDays(5),
                'end_date' => Carbon::now()->addDays(10),
                'status' => 'approved',
            ]);

            // Should be available when excluding its own booking
            $isAvailable = $this->vehicle->isAvailableForDates(
                Carbon::now()->addDays(5)->format('Y-m-d'),
                Carbon::now()->addDays(10)->format('Y-m-d'),
                $booking->id
            );
            expect($isAvailable)->toBeTrue();
        });
    });
});
