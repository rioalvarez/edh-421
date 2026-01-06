<?php

namespace App\Models;

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
        return match($this->status) {
            'approved' => 'Disetujui',
            'in_use' => 'Sedang Digunakan',
            'completed' => 'Selesai',
            'cancelled' => 'Dibatalkan',
            default => $this->status,
        };
    }

    public function getStatusColorAttribute(): string
    {
        return match($this->status) {
            'approved' => 'info',
            'in_use' => 'warning',
            'completed' => 'success',
            'cancelled' => 'danger',
            default => 'gray',
        };
    }

    public function getFuelLevelLabelAttribute(): ?string
    {
        if (!$this->fuel_level) return null;

        return match($this->fuel_level) {
            'empty' => 'Kosong (E)',
            'quarter' => '1/4',
            'half' => '1/2',
            'three_quarter' => '3/4',
            'full' => 'Penuh (F)',
            default => $this->fuel_level,
        };
    }

    public function getPassengersListAttribute(): string
    {
        if (empty($this->passengers)) return '-';
        return implode(', ', $this->passengers);
    }

    public function getDurationDaysAttribute(): int
    {
        return $this->start_date->diffInDays($this->end_date) + 1;
    }

    public function getDistanceTraveledAttribute(): ?int
    {
        if (!$this->start_odometer || !$this->end_odometer) return null;
        return $this->end_odometer - $this->start_odometer;
    }

    // Helper methods
    public function isActive(): bool
    {
        return in_array($this->status, ['approved', 'in_use']);
    }

    public function isPending(): bool
    {
        return $this->status === 'approved' && $this->start_date->isFuture();
    }

    public function isOngoing(): bool
    {
        return $this->status === 'in_use' ||
            ($this->status === 'approved' && $this->start_date->isPast() && $this->end_date->isFuture());
    }

    public function canBeEdited(): bool
    {
        return $this->status === 'approved' && $this->start_date->isFuture();
    }

    public function canBeCancelled(): bool
    {
        return in_array($this->status, ['approved']) && $this->start_date->isFuture();
    }

    public function canBeReturned(): bool
    {
        return in_array($this->status, ['approved', 'in_use']) && !$this->returned_at;
    }

    public function needsReturn(): bool
    {
        return in_array($this->status, ['approved', 'in_use']) &&
            $this->end_date->isPast() &&
            !$this->returned_at;
    }

    public function markAsInUse(): void
    {
        $this->update(['status' => 'in_use']);
    }

    public function markAsReturned(array $returnData): void
    {
        $this->update([
            'status' => 'completed',
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
            'status' => 'cancelled',
            'cancellation_reason' => $reason,
        ]);
    }

    // Static helper methods
    public static function userHasUnreturnedBooking(int $userId): bool
    {
        return self::where('user_id', $userId)
            ->whereIn('status', ['approved', 'in_use'])
            ->where('end_date', '<', today())
            ->whereNull('returned_at')
            ->exists();
    }

    public static function getUserUnreturnedBooking(int $userId): ?self
    {
        return self::where('user_id', $userId)
            ->whereIn('status', ['approved', 'in_use'])
            ->where('end_date', '<', today())
            ->whereNull('returned_at')
            ->first();
    }

    public static function isVehicleAvailable(int $vehicleId, string $startDate, string $endDate, ?int $excludeBookingId = null): bool
    {
        $query = self::where('vehicle_id', $vehicleId)
            ->whereIn('status', ['approved', 'in_use'])
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

        return !$query->exists();
    }

    // Scopes
    public function scopeActive($query)
    {
        return $query->whereIn('status', ['approved', 'in_use']);
    }

    public function scopeCompleted($query)
    {
        return $query->where('status', 'completed');
    }

    public function scopeNeedsReturn($query)
    {
        return $query->whereIn('status', ['approved', 'in_use'])
            ->where('end_date', '<', today())
            ->whereNull('returned_at');
    }

    public function scopeUpcoming($query)
    {
        return $query->where('status', 'approved')
            ->where('start_date', '>', today());
    }

    public function scopeOngoing($query)
    {
        return $query->whereIn('status', ['approved', 'in_use'])
            ->where('start_date', '<=', today())
            ->where('end_date', '>=', today());
    }
}
