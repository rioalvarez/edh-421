<?php

use App\Models\Device;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Carbon\Carbon;

uses(RefreshDatabase::class);

beforeEach(function () {
    $this->user = User::factory()->create();
});

describe('Device Model', function () {

    describe('Display Name Accessor', function () {

        it('returns hostname when hostname is set', function () {
            $device = new Device([
                'hostname' => 'DESKTOP-ABC123',
                'brand' => 'Dell',
                'model' => 'Optiplex 7080',
            ]);

            expect($device->display_name)->toBe('DESKTOP-ABC123');
        });

        it('returns brand and model when hostname is not set', function () {
            $device = new Device([
                'hostname' => null,
                'brand' => 'Dell',
                'model' => 'Optiplex 7080',
            ]);

            expect($device->display_name)->toBe('Dell Optiplex 7080');
        });

        it('returns Device #id when hostname and brand/model are not set', function () {
            $device = Device::create([
                'user_id' => $this->user->id,
                'hostname' => null,
                'brand' => null,
                'model' => null,
                'status' => 'active',
            ]);

            expect($device->display_name)->toBe("Device #{$device->id}");
        });
    });

    describe('Full Specs Accessor', function () {

        it('returns formatted specs with all components', function () {
            $device = new Device([
                'processor' => 'Intel Core i7-10700',
                'ram' => '16GB',
                'storage_type' => 'SSD',
                'storage_capacity' => '512GB',
            ]);

            expect($device->full_specs)->toBe('Intel Core i7-10700 | 16GB RAM | 512GB SSD');
        });

        it('returns partial specs when some components are missing', function () {
            $device = new Device([
                'processor' => 'Intel Core i7-10700',
                'ram' => '16GB',
                'storage_type' => null,
                'storage_capacity' => null,
            ]);

            expect($device->full_specs)->toBe('Intel Core i7-10700 | 16GB RAM');
        });

        it('returns empty string when no specs are set', function () {
            $device = new Device([
                'processor' => null,
                'ram' => null,
                'storage_type' => null,
                'storage_capacity' => null,
            ]);

            expect($device->full_specs)->toBe('');
        });

        it('excludes storage when only storage_type is set', function () {
            $device = new Device([
                'processor' => 'Intel Core i5',
                'ram' => '8GB',
                'storage_type' => 'SSD',
                'storage_capacity' => null,
            ]);

            expect($device->full_specs)->toBe('Intel Core i5 | 8GB RAM');
        });
    });

    describe('Warranty Expiry', function () {

        it('isWarrantyExpired returns true when warranty is in the past', function () {
            $device = new Device([
                'warranty_expiry' => Carbon::yesterday(),
            ]);

            expect($device->isWarrantyExpired())->toBeTrue();
        });

        it('isWarrantyExpired returns false when warranty is in the future', function () {
            $device = new Device([
                'warranty_expiry' => Carbon::tomorrow(),
            ]);

            expect($device->isWarrantyExpired())->toBeFalse();
        });

        it('isWarrantyExpired returns false when warranty is null', function () {
            $device = new Device([
                'warranty_expiry' => null,
            ]);

            expect($device->isWarrantyExpired())->toBeFalse();
        });

        it('isWarrantyExpired returns true when warranty is today (already past start of day)', function () {
            // Set warranty to start of today which is already past
            $device = new Device([
                'warranty_expiry' => Carbon::today()->startOfDay(),
            ]);

            // This depends on current time - if we're past midnight, it should be true
            // For consistent testing, we'll test with a clearly past date
            $device->warranty_expiry = Carbon::now()->subHour();
            expect($device->isWarrantyExpired())->toBeTrue();
        });
    });

    describe('Assignment Status', function () {

        it('isAssigned returns true when user_id is set', function () {
            $device = new Device([
                'user_id' => 1,
            ]);

            expect($device->isAssigned())->toBeTrue();
        });

        it('isAssigned returns false when user_id is null', function () {
            $device = new Device([
                'user_id' => null,
            ]);

            expect($device->isAssigned())->toBeFalse();
        });
    });

    describe('Relationships', function () {

        it('belongs to a user', function () {
            $device = Device::create([
                'user_id' => $this->user->id,
                'hostname' => 'DESKTOP-TEST',
                'brand' => 'Dell',
                'model' => 'Optiplex',
                'status' => 'active',
            ]);

            expect($device->user)->toBeInstanceOf(User::class);
            expect($device->user->id)->toBe($this->user->id);
        });

        it('can have null user', function () {
            $device = Device::create([
                'user_id' => null,
                'hostname' => 'DESKTOP-UNASSIGNED',
                'brand' => 'HP',
                'model' => 'ProDesk',
                'status' => 'active',
            ]);

            expect($device->user)->toBeNull();
        });

        it('has many tickets', function () {
            $device = Device::create([
                'user_id' => $this->user->id,
                'hostname' => 'DESKTOP-TEST',
                'brand' => 'Dell',
                'model' => 'Optiplex',
                'status' => 'active',
            ]);

            // Check relationship exists
            expect($device->tickets())->toBeInstanceOf(\Illuminate\Database\Eloquent\Relations\HasMany::class);
        });

        it('has many attribute values', function () {
            $device = Device::create([
                'user_id' => $this->user->id,
                'hostname' => 'DESKTOP-TEST',
                'brand' => 'Dell',
                'model' => 'Optiplex',
                'status' => 'active',
            ]);

            expect($device->attributeValues())->toBeInstanceOf(\Illuminate\Database\Eloquent\Relations\HasMany::class);
        });
    });

    describe('Date Casting', function () {

        it('casts purchase_date to Carbon instance', function () {
            $device = Device::create([
                'user_id' => $this->user->id,
                'hostname' => 'DESKTOP-TEST',
                'brand' => 'Dell',
                'model' => 'Optiplex',
                'status' => 'active',
                'purchase_date' => '2024-01-15',
            ]);

            expect($device->purchase_date)->toBeInstanceOf(Carbon::class);
            expect($device->purchase_date->format('Y-m-d'))->toBe('2024-01-15');
        });

        it('casts warranty_expiry to Carbon instance', function () {
            $device = Device::create([
                'user_id' => $this->user->id,
                'hostname' => 'DESKTOP-TEST',
                'brand' => 'Dell',
                'model' => 'Optiplex',
                'status' => 'active',
                'warranty_expiry' => '2027-01-15',
            ]);

            expect($device->warranty_expiry)->toBeInstanceOf(Carbon::class);
            expect($device->warranty_expiry->format('Y-m-d'))->toBe('2027-01-15');
        });
    });
});
