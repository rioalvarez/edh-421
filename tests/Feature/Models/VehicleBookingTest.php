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

describe('VehicleBooking Model', function () {

    describe('Booking Number Generation', function () {

        it('generates booking number automatically on create', function () {
            $booking = VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::tomorrow(),
                'end_date' => Carbon::tomorrow()->addDays(2),
                'status' => 'approved',
            ]);

            expect($booking->booking_number)->not->toBeNull();
            expect($booking->booking_number)->toStartWith('KDO-');
        });

        it('generates booking number with correct format', function () {
            $booking = VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::tomorrow(),
                'end_date' => Carbon::tomorrow()->addDays(2),
                'status' => 'approved',
            ]);

            $expectedPrefix = 'KDO-' . now()->format('Ymd');
            expect($booking->booking_number)->toStartWith($expectedPrefix);
            expect($booking->booking_number)->toMatch('/^KDO-\d{8}-\d{4}$/');
        });

        it('increments sequence number for bookings created on same day', function () {
            $booking1 = VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting 1',
                'destination' => 'Jakarta',
                'start_date' => Carbon::tomorrow(),
                'end_date' => Carbon::tomorrow()->addDays(1),
                'status' => 'approved',
            ]);

            $booking2 = VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting 2',
                'destination' => 'Bandung',
                'start_date' => Carbon::tomorrow()->addDays(5),
                'end_date' => Carbon::tomorrow()->addDays(6),
                'status' => 'approved',
            ]);

            $seq1 = (int) substr($booking1->booking_number, -4);
            $seq2 = (int) substr($booking2->booking_number, -4);

            expect($seq2)->toBe($seq1 + 1);
        });
    });

    describe('Status Label Accessor', function () {

        it('returns Disetujui for approved status', function () {
            $booking = new VehicleBooking(['status' => 'approved']);
            expect($booking->status_label)->toBe('Disetujui');
        });

        it('returns Sedang Digunakan for in_use status', function () {
            $booking = new VehicleBooking(['status' => 'in_use']);
            expect($booking->status_label)->toBe('Sedang Digunakan');
        });

        it('returns Selesai for completed status', function () {
            $booking = new VehicleBooking(['status' => 'completed']);
            expect($booking->status_label)->toBe('Selesai');
        });

        it('returns Dibatalkan for cancelled status', function () {
            $booking = new VehicleBooking(['status' => 'cancelled']);
            expect($booking->status_label)->toBe('Dibatalkan');
        });
    });

    describe('Status Color Accessor', function () {

        it('returns info for approved status', function () {
            $booking = new VehicleBooking(['status' => 'approved']);
            expect($booking->status_color)->toBe('info');
        });

        it('returns warning for in_use status', function () {
            $booking = new VehicleBooking(['status' => 'in_use']);
            expect($booking->status_color)->toBe('warning');
        });

        it('returns success for completed status', function () {
            $booking = new VehicleBooking(['status' => 'completed']);
            expect($booking->status_color)->toBe('success');
        });

        it('returns danger for cancelled status', function () {
            $booking = new VehicleBooking(['status' => 'cancelled']);
            expect($booking->status_color)->toBe('danger');
        });
    });

    describe('Fuel Level Label Accessor', function () {

        it('returns Kosong (E) for empty fuel level', function () {
            $booking = new VehicleBooking(['fuel_level' => 'empty']);
            expect($booking->fuel_level_label)->toBe('Kosong (E)');
        });

        it('returns 1/4 for quarter fuel level', function () {
            $booking = new VehicleBooking(['fuel_level' => 'quarter']);
            expect($booking->fuel_level_label)->toBe('1/4');
        });

        it('returns 1/2 for half fuel level', function () {
            $booking = new VehicleBooking(['fuel_level' => 'half']);
            expect($booking->fuel_level_label)->toBe('1/2');
        });

        it('returns 3/4 for three_quarter fuel level', function () {
            $booking = new VehicleBooking(['fuel_level' => 'three_quarter']);
            expect($booking->fuel_level_label)->toBe('3/4');
        });

        it('returns Penuh (F) for full fuel level', function () {
            $booking = new VehicleBooking(['fuel_level' => 'full']);
            expect($booking->fuel_level_label)->toBe('Penuh (F)');
        });

        it('returns null when fuel_level is null', function () {
            $booking = new VehicleBooking(['fuel_level' => null]);
            expect($booking->fuel_level_label)->toBeNull();
        });
    });

    describe('Passengers List Accessor', function () {

        it('returns dash when passengers is empty', function () {
            $booking = new VehicleBooking(['passengers' => []]);
            expect($booking->passengers_list)->toBe('-');
        });

        it('returns comma separated list of passengers', function () {
            $booking = new VehicleBooking(['passengers' => ['John Doe', 'Jane Doe', 'Bob']]);
            expect($booking->passengers_list)->toBe('John Doe, Jane Doe, Bob');
        });
    });

    describe('Duration Days Accessor', function () {

        it('calculates correct duration in days', function () {
            $booking = new VehicleBooking([
                'start_date' => Carbon::parse('2024-01-01'),
                'end_date' => Carbon::parse('2024-01-05'),
            ]);
            expect($booking->duration_days)->toBe(5);
        });

        it('returns 1 for same day booking', function () {
            $booking = new VehicleBooking([
                'start_date' => Carbon::parse('2024-01-01'),
                'end_date' => Carbon::parse('2024-01-01'),
            ]);
            expect($booking->duration_days)->toBe(1);
        });
    });

    describe('Distance Traveled Accessor', function () {

        it('calculates distance when both odometer values exist', function () {
            $booking = new VehicleBooking([
                'start_odometer' => 10000,
                'end_odometer' => 10500,
            ]);
            expect($booking->distance_traveled)->toBe(500);
        });

        it('returns null when start_odometer is null', function () {
            $booking = new VehicleBooking([
                'start_odometer' => null,
                'end_odometer' => 10500,
            ]);
            expect($booking->distance_traveled)->toBeNull();
        });

        it('returns null when end_odometer is null', function () {
            $booking = new VehicleBooking([
                'start_odometer' => 10000,
                'end_odometer' => null,
            ]);
            expect($booking->distance_traveled)->toBeNull();
        });
    });

    describe('Helper Methods', function () {

        it('isActive returns true for approved status', function () {
            $booking = new VehicleBooking(['status' => 'approved']);
            expect($booking->isActive())->toBeTrue();
        });

        it('isActive returns true for in_use status', function () {
            $booking = new VehicleBooking(['status' => 'in_use']);
            expect($booking->isActive())->toBeTrue();
        });

        it('isActive returns false for completed status', function () {
            $booking = new VehicleBooking(['status' => 'completed']);
            expect($booking->isActive())->toBeFalse();
        });

        it('isActive returns false for cancelled status', function () {
            $booking = new VehicleBooking(['status' => 'cancelled']);
            expect($booking->isActive())->toBeFalse();
        });

        it('isPending returns true when approved and start_date is future', function () {
            $booking = new VehicleBooking([
                'status' => 'approved',
                'start_date' => Carbon::tomorrow(),
            ]);
            expect($booking->isPending())->toBeTrue();
        });

        it('isPending returns false when start_date is past', function () {
            $booking = new VehicleBooking([
                'status' => 'approved',
                'start_date' => Carbon::yesterday(),
            ]);
            expect($booking->isPending())->toBeFalse();
        });

        it('canBeEdited returns true when approved and start_date is future', function () {
            $booking = new VehicleBooking([
                'status' => 'approved',
                'start_date' => Carbon::tomorrow(),
            ]);
            expect($booking->canBeEdited())->toBeTrue();
        });

        it('canBeEdited returns false when start_date is past', function () {
            $booking = new VehicleBooking([
                'status' => 'approved',
                'start_date' => Carbon::yesterday(),
            ]);
            expect($booking->canBeEdited())->toBeFalse();
        });

        it('canBeEdited returns false when status is not approved', function () {
            $booking = new VehicleBooking([
                'status' => 'in_use',
                'start_date' => Carbon::tomorrow(),
            ]);
            expect($booking->canBeEdited())->toBeFalse();
        });

        it('canBeCancelled returns true when approved and start_date is future', function () {
            $booking = new VehicleBooking([
                'status' => 'approved',
                'start_date' => Carbon::tomorrow(),
            ]);
            expect($booking->canBeCancelled())->toBeTrue();
        });

        it('canBeCancelled returns false when status is in_use', function () {
            $booking = new VehicleBooking([
                'status' => 'in_use',
                'start_date' => Carbon::tomorrow(),
            ]);
            expect($booking->canBeCancelled())->toBeFalse();
        });

        it('canBeReturned returns true when active and not yet returned', function () {
            $booking = new VehicleBooking([
                'status' => 'in_use',
                'returned_at' => null,
            ]);
            expect($booking->canBeReturned())->toBeTrue();
        });

        it('canBeReturned returns false when already returned', function () {
            $booking = new VehicleBooking([
                'status' => 'in_use',
                'returned_at' => Carbon::now(),
            ]);
            expect($booking->canBeReturned())->toBeFalse();
        });

        it('needsReturn returns true when active, end_date past, and not returned', function () {
            $booking = new VehicleBooking([
                'status' => 'in_use',
                'end_date' => Carbon::yesterday(),
                'returned_at' => null,
            ]);
            expect($booking->needsReturn())->toBeTrue();
        });

        it('needsReturn returns false when already returned', function () {
            $booking = new VehicleBooking([
                'status' => 'in_use',
                'end_date' => Carbon::yesterday(),
                'returned_at' => Carbon::now(),
            ]);
            expect($booking->needsReturn())->toBeFalse();
        });
    });

    describe('Action Methods', function () {

        it('markAsInUse updates status to in_use', function () {
            $booking = VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::today(),
                'end_date' => Carbon::tomorrow(),
                'status' => 'approved',
            ]);

            $booking->markAsInUse();

            expect($booking->fresh()->status)->toBe('in_use');
        });

        it('markAsReturned updates booking with return data', function () {
            $booking = VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::yesterday(),
                'end_date' => Carbon::today(),
                'status' => 'in_use',
                'start_odometer' => 10000,
            ]);

            $booking->markAsReturned([
                'end_odometer' => 10500,
                'fuel_level' => 'half',
                'return_condition' => 'good',
                'return_notes' => 'Everything fine',
            ]);

            $booking->refresh();
            expect($booking->status)->toBe('completed');
            expect($booking->end_odometer)->toBe(10500);
            expect($booking->fuel_level)->toBe('half');
            expect($booking->return_condition)->toBe('good');
            expect($booking->return_notes)->toBe('Everything fine');
            expect($booking->returned_at)->not->toBeNull();
        });

        it('cancel updates status and sets cancellation reason', function () {
            $booking = VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::tomorrow(),
                'end_date' => Carbon::tomorrow()->addDay(),
                'status' => 'approved',
            ]);

            $booking->cancel('Schedule changed');

            expect($booking->fresh()->status)->toBe('cancelled');
            expect($booking->fresh()->cancellation_reason)->toBe('Schedule changed');
        });
    });

    describe('Static Helper Methods', function () {

        it('userHasUnreturnedBooking returns true when user has unreturned booking', function () {
            VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::now()->subDays(5),
                'end_date' => Carbon::yesterday(),
                'status' => 'in_use',
                'returned_at' => null,
            ]);

            expect(VehicleBooking::userHasUnreturnedBooking($this->user->id))->toBeTrue();
        });

        it('userHasUnreturnedBooking returns false when all bookings are returned', function () {
            VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::now()->subDays(5),
                'end_date' => Carbon::yesterday(),
                'status' => 'completed',
                'returned_at' => Carbon::now(),
            ]);

            expect(VehicleBooking::userHasUnreturnedBooking($this->user->id))->toBeFalse();
        });

        it('isVehicleAvailable returns true when no conflicting bookings', function () {
            expect(VehicleBooking::isVehicleAvailable(
                $this->vehicle->id,
                Carbon::tomorrow()->format('Y-m-d'),
                Carbon::tomorrow()->addDays(3)->format('Y-m-d')
            ))->toBeTrue();
        });

        it('isVehicleAvailable returns false when booking overlaps', function () {
            VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::tomorrow(),
                'end_date' => Carbon::tomorrow()->addDays(3),
                'status' => 'approved',
            ]);

            expect(VehicleBooking::isVehicleAvailable(
                $this->vehicle->id,
                Carbon::tomorrow()->addDay()->format('Y-m-d'),
                Carbon::tomorrow()->addDays(5)->format('Y-m-d')
            ))->toBeFalse();
        });
    });

    describe('Scopes', function () {

        beforeEach(function () {
            VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Active Booking',
                'destination' => 'Jakarta',
                'start_date' => Carbon::yesterday(),
                'end_date' => Carbon::tomorrow(),
                'status' => 'in_use',
            ]);
            VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Completed Booking',
                'destination' => 'Bandung',
                'start_date' => Carbon::now()->subDays(10),
                'end_date' => Carbon::now()->subDays(5),
                'status' => 'completed',
                'returned_at' => Carbon::now()->subDays(5),
            ]);
            VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Upcoming Booking',
                'destination' => 'Surabaya',
                'start_date' => Carbon::tomorrow()->addDays(3),
                'end_date' => Carbon::tomorrow()->addDays(5),
                'status' => 'approved',
            ]);
        });

        it('active scope returns only active bookings', function () {
            $bookings = VehicleBooking::active()->get();
            expect($bookings)->toHaveCount(2); // in_use and upcoming approved
        });

        it('completed scope returns only completed bookings', function () {
            $bookings = VehicleBooking::completed()->get();
            expect($bookings)->toHaveCount(1);
            expect($bookings->first()->purpose)->toBe('Completed Booking');
        });

        it('upcoming scope returns only upcoming approved bookings', function () {
            $bookings = VehicleBooking::upcoming()->get();
            expect($bookings)->toHaveCount(1);
            expect($bookings->first()->purpose)->toBe('Upcoming Booking');
        });

        it('ongoing scope returns bookings happening now', function () {
            $bookings = VehicleBooking::ongoing()->get();
            expect($bookings)->toHaveCount(1);
            expect($bookings->first()->purpose)->toBe('Active Booking');
        });
    });

    describe('Relationships', function () {

        it('belongs to a user', function () {
            $booking = VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::tomorrow(),
                'end_date' => Carbon::tomorrow()->addDay(),
                'status' => 'approved',
            ]);

            expect($booking->user)->toBeInstanceOf(User::class);
            expect($booking->user->id)->toBe($this->user->id);
        });

        it('belongs to a vehicle', function () {
            $booking = VehicleBooking::create([
                'vehicle_id' => $this->vehicle->id,
                'user_id' => $this->user->id,
                'driver_name' => 'Driver Test',
                'document_number' => 'DOC-001',
                'purpose' => 'Meeting',
                'destination' => 'Jakarta',
                'start_date' => Carbon::tomorrow(),
                'end_date' => Carbon::tomorrow()->addDay(),
                'status' => 'approved',
            ]);

            expect($booking->vehicle)->toBeInstanceOf(Vehicle::class);
            expect($booking->vehicle->id)->toBe($this->vehicle->id);
        });
    });
});
