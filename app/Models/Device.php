<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Str;

class Device extends Model
{
    protected $guarded = ['id'];

    protected $casts = [
        'purchase_date' => 'date',
        'warranty_expiry' => 'date',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function attributeValues(): HasMany
    {
        return $this->hasMany(DeviceAttributeValue::class);
    }

    public function tickets(): HasMany
    {
        return $this->hasMany(Ticket::class);
    }

    public function getDisplayNameAttribute(): string
    {
        if ($this->hostname) {
            return $this->hostname;
        }
        if ($this->brand && $this->model) {
            return "{$this->brand} {$this->model}";
        }
        return "Device #{$this->id}";
    }

    public function getFullSpecsAttribute(): string
    {
        $specs = [];
        if ($this->processor) $specs[] = $this->processor;
        if ($this->ram) $specs[] = $this->ram . ' RAM';
        if ($this->storage_type && $this->storage_capacity) {
            $specs[] = $this->storage_capacity . ' ' . $this->storage_type;
        }
        return implode(' | ', $specs);
    }

    public function isWarrantyExpired(): bool
    {
        if (!$this->warranty_expiry) {
            return false;
        }
        return $this->warranty_expiry->isPast();
    }

    public function isAssigned(): bool
    {
        return $this->user_id !== null;
    }

    public function getDynamicAttribute(string $slug): ?string
    {
        // Cache attribute lookup
        $attribute = Cache::remember(
            "device_attribute_{$slug}",
            now()->addHours(24),
            fn () => DeviceAttribute::where('slug', $slug)->first()
        );

        if (!$attribute) {
            return null;
        }

        // Cache the value for this device
        return Cache::remember(
            "device_{$this->id}_attr_{$attribute->id}",
            now()->addMinutes(30),
            fn () => $this->attributeValues()
                ->where('device_attribute_id', $attribute->id)
                ->first()?->value
        );
    }

    public function setDynamicAttribute(string $slug, ?string $value): void
    {
        $attribute = Cache::remember(
            "device_attribute_{$slug}",
            now()->addHours(24),
            fn () => DeviceAttribute::where('slug', $slug)->first()
        );

        if (!$attribute) {
            return;
        }

        $this->attributeValues()->updateOrCreate(
            ['device_attribute_id' => $attribute->id],
            ['value' => $value]
        );

        // Clear the cache for this attribute value
        Cache::forget("device_{$this->id}_attr_{$attribute->id}");
    }
}
