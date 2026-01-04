<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Str;

class DeviceAttribute extends Model
{
    protected $guarded = ['id'];

    protected $casts = [
        'options' => 'array',
        'is_required' => 'boolean',
        'is_active' => 'boolean',
    ];

    protected static function booted(): void
    {
        static::creating(function (DeviceAttribute $attribute) {
            if (empty($attribute->slug)) {
                $attribute->slug = Str::slug($attribute->name);
            }
        });

        static::updating(function (DeviceAttribute $attribute) {
            if ($attribute->isDirty('name') && !$attribute->isDirty('slug')) {
                $attribute->slug = Str::slug($attribute->name);
            }
        });
    }

    public function values(): HasMany
    {
        return $this->hasMany(DeviceAttributeValue::class);
    }

    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    public function scopeOrdered($query)
    {
        return $query->orderBy('sort_order')->orderBy('name');
    }

    public function getOptionsArrayAttribute(): array
    {
        if (!$this->options || !is_array($this->options)) {
            return [];
        }
        return $this->options;
    }
}
