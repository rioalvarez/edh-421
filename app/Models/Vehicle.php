<?php

namespace App\Models;

use App\Enums\VehicleBookingStatus;
use App\Enums\VehicleCondition;
use App\Enums\VehicleFuelType;
use App\Enums\VehicleOwnership;
use App\Enums\VehicleStatus;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Vehicle extends Model
{
    protected $guarded = ['id'];

    protected $casts = [
        'year' => 'integer',
        'capacity' => 'integer',
        'last_service_date' => 'date',
        'tax_expiry_date' => 'date',
        'inspection_expiry_date' => 'date',
    ];

    // Relationships
    public function bookings(): HasMany
    {
        return $this->hasMany(VehicleBooking::class);
    }

    public function activeBookings(): HasMany
    {
        return $this->hasMany(VehicleBooking::class)
            ->whereIn('status', VehicleBookingStatus::activeValues());
    }

    // Accessors
    public function getDisplayNameAttribute(): string
    {
        return "{$this->brand} {$this->model} ({$this->plate_number})";
    }

    public function getStatusLabelAttribute(): string
    {
        return VehicleStatus::tryLabel($this->status);
    }

    public function getStatusColorAttribute(): string
    {
        return VehicleStatus::tryColor($this->status);
    }

    public function getConditionLabelAttribute(): string
    {
        return VehicleCondition::tryLabel($this->condition);
    }

    public function getConditionColorAttribute(): string
    {
        return VehicleCondition::tryColor($this->condition);
    }

    public function getFuelTypeLabelAttribute(): string
    {
        return VehicleFuelType::tryLabel($this->fuel_type);
    }

    public function getOwnershipLabelAttribute(): string
    {
        return VehicleOwnership::tryLabel($this->ownership);
    }

    // Helper methods
    public function isAvailable(): bool
    {
        return $this->status === VehicleStatus::Available->value;
    }

    public function isAvailableForDates(string $startDate, string $endDate, ?int $excludeBookingId = null): bool
    {
        $query = $this->bookings()
            ->whereIn('status', VehicleBookingStatus::activeValues())
            ->where(function ($q) use ($startDate, $endDate) {
                $q->whereBetween('start_date', [$startDate, $endDate])
                    ->orWhereBetween('end_date', [$startDate, $endDate])
                    ->orWhere(function ($q2) use ($startDate, $endDate) {
                        $q2->where('start_date', '<=', $startDate)
                            ->where('end_date', '>=', $endDate);
                    });
            });

        if ($excludeBookingId) {
            $query->where('id', '!=', $excludeBookingId);
        }

        return ! $query->exists();
    }

    public function isTaxExpired(): bool
    {
        return $this->tax_expiry_date && $this->tax_expiry_date->isPast();
    }

    public function isInspectionExpired(): bool
    {
        return $this->inspection_expiry_date && $this->inspection_expiry_date->isPast();
    }

    public function getTaxExpiryWarningAttribute(): bool
    {
        if (! $this->tax_expiry_date) {
            return false;
        }

        return abs($this->tax_expiry_date->diffInDays(now())) <= 30 && ! $this->tax_expiry_date->isPast();
    }

    public function getInspectionExpiryWarningAttribute(): bool
    {
        if (! $this->inspection_expiry_date) {
            return false;
        }

        return abs($this->inspection_expiry_date->diffInDays(now())) <= 30 && ! $this->inspection_expiry_date->isPast();
    }

    // Scopes
    public function scopeAvailable($query)
    {
        return $query->where('status', VehicleStatus::Available->value);
    }

    public function scopeActive($query)
    {
        return $query->whereIn('status', VehicleStatus::activeValues());
    }
}
