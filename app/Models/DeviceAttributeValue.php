<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DeviceAttributeValue extends Model
{
    protected $guarded = ['id'];

    public function device(): BelongsTo
    {
        return $this->belongsTo(Device::class);
    }

    public function attribute(): BelongsTo
    {
        return $this->belongsTo(DeviceAttribute::class, 'device_attribute_id');
    }
}
