<?php

namespace App\Observers;

use App\Enums\VehicleBookingStatus;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource;
use App\Models\User;
use App\Models\VehicleBooking;
use App\Notifications\VehicleBookingNotification;
use Illuminate\Support\Facades\Notification;

class VehicleBookingObserver
{
    /**
     * Handle the VehicleBooking "created" event.
     */
    public function created(VehicleBooking $booking): void
    {
        VehicleBookingResource::clearNavigationCache($booking);

        // Queued notifications to all admins except booking creator
        $admins = User::itAdmins()->where('id', '!=', $booking->user_id)->get();

        Notification::send(
            $admins,
            VehicleBookingNotification::created(
                $booking->id,
                $booking->booking_number,
                $booking->vehicle->display_name,
                $booking->destination,
            )
        );

        // Confirmation to requester
        /** @var User $owner */
        $owner = $booking->user;
        $owner->notify(
            VehicleBookingNotification::approved(
                $booking->id,
                $booking->booking_number,
                $booking->vehicle->display_name,
            )
        );
    }

    /**
     * Handle the VehicleBooking "updated" event.
     */
    public function updated(VehicleBooking $booking): void
    {
        VehicleBookingResource::clearNavigationCache($booking);

        if (! $booking->isDirty('status')) {
            return;
        }

        $newStatus = $booking->status;
        $newStatusLabel = VehicleBookingStatus::tryLabel($newStatus) ?? $newStatus;
        $newStatusColor = VehicleBookingStatus::tryColor($newStatus);

        // Notify requester if they didn't make the change
        if ($booking->user_id !== auth()->id()) {
            $cancellationReason = ($newStatus === VehicleBookingStatus::Cancelled->value)
                ? $booking->cancellation_reason
                : null;

            /** @var User $owner */
            $owner = $booking->user;
            $owner->notify(
                VehicleBookingNotification::statusChanged(
                    $booking->id,
                    $booking->booking_number,
                    $newStatusLabel,
                    $newStatusColor,
                    $cancellationReason,
                )
            );
        }

        // Notify all admins when vehicle is returned
        if ($newStatus === VehicleBookingStatus::Completed->value) {
            $admins = User::itAdmins()->get();

            Notification::send(
                $admins,
                VehicleBookingNotification::returned(
                    $booking->id,
                    $booking->vehicle->display_name,
                    $booking->user->name,
                )
            );
        }
    }

    /**
     * Handle the VehicleBooking "deleted" event.
     */
    public function deleted(VehicleBooking $booking): void
    {
        VehicleBookingResource::clearNavigationCache($booking);
    }

    /**
     * Handle the VehicleBooking "restored" event.
     */
    public function restored(VehicleBooking $booking): void
    {
        VehicleBookingResource::clearNavigationCache($booking);
    }

    /**
     * Handle the VehicleBooking "force deleted" event.
     */
    public function forceDeleted(VehicleBooking $booking): void
    {
        VehicleBookingResource::clearNavigationCache($booking);
    }
}
