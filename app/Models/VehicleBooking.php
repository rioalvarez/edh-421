<?php

namespace App\Models;

use App\Enums\FuelLevel;
use App\Enums\VehicleBookingStatus;
use App\Observers\VehicleBookingObserver;
use Illuminate\Database\Eloquent\Attributes\ObservedBy;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[ObservedBy([VehicleBookingObserver::class])]
class VehicleBooking extends Model
{
    protected $guarded = ['id'];

    protected $casts = [
        'passengers' => 'array',
        'start_date' => 'date',
        'end_date' => 'date',
        'departure_time' => 'datetime:H:i',
        'returned_at' => 'datetime',
        'start_odometer' => 'integer',
        'end_odometer' => 'integer',
    ];

    protected static function booted(): void
    {
        static::creating(function (VehicleBooking $booking) {
            if (empty($booking->booking_number)) {
                $booking->booking_number = self::generateBookingNumber();
            }
        });
    }

    public static function generateBookingNumber(): string
    {
        $prefix = 'KDO';
        $date = now()->format('Ymd');
        $lastBooking = self::whereDate('created_at', today())
            ->orderBy('id', 'desc')
            ->first();

        $sequence = $lastBooking ? (int) substr($lastBooking->booking_number, -4) + 1 : 1;

        return sprintf('%s-%s-%04d', $prefix, $date, $sequence);
    }

    // Relationships
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function vehicle(): BelongsTo
    {
        return $this->belongsTo(Vehicle::class);
    }

    // Accessors
    public function getStatusLabelAttribute(): string
    {
        return VehicleBookingStatus::tryLabel($this->status);
    }

    public function getStatusColorAttribute(): string
    {
        return VehicleBookingStatus::tryColor($this->status);
    }

    public function getFuelLevelLabelAttribute(): ?string
    {
        if (! $this->fuel_level) {
            return null;
        }

        return FuelLevel::tryLabel($this->fuel_level);
    }

    public function getPassengersListAttribute(): string
    {
        if (empty($this->passengers)) {
            return '-';
        }

        return implode(', ', $this->passengers);
    }

    public function getDurationDaysAttribute(): int
    {
        return $this->start_date->diffInDays($this->end_date) + 1;
    }

    public function getDistanceTraveledAttribute(): ?int
    {
        if (! $this->start_odometer || ! $this->end_odometer) {
            return null;
        }

        return $this->end_odometer - $this->start_odometer;
    }

    public function vehicleName(): string
    {
        $vehicle = $this->vehicle;

        if (! $vehicle instanceof Vehicle) {
            return '-';
        }

        return "{$vehicle->brand} {$vehicle->model}";
    }

    public function vehicleReturnDescription(): string
    {
        $vehicle = $this->vehicle;

        if (! $vehicle instanceof Vehicle) {
            return 'Kendaraan: -';
        }

        return "Kendaraan: {$vehicle->plate_number} - {$vehicle->brand} {$vehicle->model}";
    }

    // Helper methods
    public function isActive(): bool
    {
        return in_array($this->status, VehicleBookingStatus::activeValues(), true);
    }

    public function isPending(): bool
    {
        return $this->status === VehicleBookingStatus::Approved->value && $this->start_date->isFuture();
    }

    public function isOngoing(): bool
    {
        return $this->status === VehicleBookingStatus::InUse->value ||
            ($this->status === VehicleBookingStatus::Approved->value && $this->start_date->isPast() && $this->end_date->isFuture());
    }

    public function canBeEdited(): bool
    {
        return $this->status === VehicleBookingStatus::Approved->value && $this->start_date->isFuture();
    }

    public function canBeCancelled(): bool
    {
        return $this->status === VehicleBookingStatus::Approved->value && $this->start_date->isFuture();
    }

    public function canBeReturned(): bool
    {
        if (! in_array($this->status, VehicleBookingStatus::activeValues(), true)) {
            return false;
        }

        if ($this->returned_at) {
            return false;
        }

        // Pengembalian hanya bisa dilakukan minimal di hari yang sama dengan tanggal peminjaman
        if (! $this->getAttributes()['start_date']) {
            return false;
        }

        return $this->start_date->lte(today());
    }

    public function needsReturn(): bool
    {
        return in_array($this->status, VehicleBookingStatus::activeValues(), true) &&
            $this->end_date->isPast() &&
            ! $this->returned_at;
    }

    public function markAsInUse(): void
    {
        $this->update(['status' => VehicleBookingStatus::InUse->value]);
    }

    public function markAsReturned(array $returnData): void
    {
        $this->update([
            'status' => VehicleBookingStatus::Completed->value,
            'end_odometer' => $returnData['end_odometer'] ?? null,
            'fuel_level' => $returnData['fuel_level'] ?? null,
            'return_condition' => $returnData['return_condition'] ?? null,
            'return_notes' => $returnData['return_notes'] ?? null,
            'returned_at' => now(),
        ]);
    }

    public function cancel(?string $reason = null): void
    {
        $this->update([
            'status' => VehicleBookingStatus::Cancelled->value,
            'cancellation_reason' => $reason,
        ]);
    }

    // Static helper methods
    public static function userHasUnreturnedBooking(int $userId): bool
    {
        return self::where('user_id', $userId)
            ->whereIn('status', VehicleBookingStatus::activeValues())
            ->where('end_date', '<', today())
            ->whereNull('returned_at')
            ->exists();
    }

    public static function getUserUnreturnedBooking(int $userId): ?self
    {
        return self::where('user_id', $userId)
            ->whereIn('status', VehicleBookingStatus::activeValues())
            ->where('end_date', '<', today())
            ->whereNull('returned_at')
            ->first();
    }

    public static function isVehicleAvailable(int $vehicleId, string $startDate, string $endDate, ?int $excludeBookingId = null): bool
    {
        $query = self::where('vehicle_id', $vehicleId)
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

    // Scopes
    public function scopeActive($query)
    {
        return $query->whereIn('status', VehicleBookingStatus::activeValues());
    }

    public function scopeCompleted($query)
    {
        return $query->where('status', VehicleBookingStatus::Completed->value);
    }

    public function scopeNeedsReturn($query)
    {
        return $query->whereIn('status', VehicleBookingStatus::activeValues())
            ->where('end_date', '<', today())
            ->whereNull('returned_at');
    }

    public function scopeUpcoming($query)
    {
        return $query->where('status', VehicleBookingStatus::Approved->value)
            ->where('start_date', '>', today());
    }

    public function scopeOngoing($query)
    {
        return $query->whereIn('status', VehicleBookingStatus::activeValues())
            ->where('start_date', '<=', today())
            ->where('end_date', '>=', today());
    }
}
