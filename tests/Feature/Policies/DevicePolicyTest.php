<?php

use App\Models\Device;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

uses(RefreshDatabase::class);

beforeEach(function () {
    $this->superAdminRole = Role::firstOrCreate(['name' => 'super_admin', 'guard_name' => 'web']);
    $this->adminRole = Role::firstOrCreate(['name' => 'Admin', 'guard_name' => 'web']);
    $this->memberRole = Role::firstOrCreate(['name' => 'Member', 'guard_name' => 'web']);

    // Create permissions
    foreach (['view_any_device', 'view_device', 'create_device', 'update_device', 'delete_device', 'delete_any_device'] as $perm) {
        Permission::firstOrCreate(['name' => $perm, 'guard_name' => 'web']);
    }

    // Admin gets all device permissions
    $this->adminRole->givePermissionTo([
        'view_any_device', 'view_device', 'create_device', 'update_device', 'delete_device',
    ]);

    $this->superAdmin = User::factory()->create();
    $this->superAdmin->assignRole('super_admin');

    $this->admin = User::factory()->create();
    $this->admin->assignRole('Admin');

    $this->member = User::factory()->create();
    $this->member->assignRole('Member');

    $this->device = Device::create([
        'type' => 'laptop',
        'brand' => 'Lenovo',
        'model' => 'ThinkPad',
        'status' => 'active',
        'condition' => 'good',
    ]);
});

describe('Device Policy', function () {

    describe('super_admin bypass', function () {

        it('super_admin can do anything', function () {
            expect($this->superAdmin->can('viewAny', Device::class))->toBeTrue();
            expect($this->superAdmin->can('view', $this->device))->toBeTrue();
            expect($this->superAdmin->can('create', Device::class))->toBeTrue();
            expect($this->superAdmin->can('update', $this->device))->toBeTrue();
            expect($this->superAdmin->can('delete', $this->device))->toBeTrue();
        });
    });

    describe('Admin with permissions', function () {

        it('admin can view devices', function () {
            expect($this->admin->can('viewAny', Device::class))->toBeTrue();
            expect($this->admin->can('view', $this->device))->toBeTrue();
        });

        it('admin can create devices', function () {
            expect($this->admin->can('create', Device::class))->toBeTrue();
        });

        it('admin can update devices', function () {
            expect($this->admin->can('update', $this->device))->toBeTrue();
        });

        it('admin can delete devices', function () {
            expect($this->admin->can('delete', $this->device))->toBeTrue();
        });
    });

    describe('Member without permissions', function () {

        it('member cannot view devices', function () {
            expect($this->member->can('viewAny', Device::class))->toBeFalse();
        });

        it('member cannot create devices', function () {
            expect($this->member->can('create', Device::class))->toBeFalse();
        });

        it('member cannot update devices', function () {
            expect($this->member->can('update', $this->device))->toBeFalse();
        });

        it('member cannot delete devices', function () {
            expect($this->member->can('delete', $this->device))->toBeFalse();
        });
    });

    describe('Unsupported abilities', function () {

        it('forceDelete is denied even for admin', function () {
            expect($this->admin->can('forceDelete', $this->device))->toBeFalse();
        });

        it('restore is denied even for admin', function () {
            expect($this->admin->can('restore', $this->device))->toBeFalse();
        });

        it('replicate is denied even for admin', function () {
            expect($this->admin->can('replicate', $this->device))->toBeFalse();
        });

        it('super_admin bypasses all abilities including unsupported ones', function () {
            // This is by design: super_admin before() returns true for everything
            expect($this->superAdmin->can('forceDelete', $this->device))->toBeTrue();
        });
    });
});
