<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\Support;

use App\Enums\DeviceType;
use App\Models\Device;
use App\Models\User;

class TicketDeviceOptions
{
    public static function forUser(?int $userId): array
    {
        if (! $userId) {
            return Device::query()
                ->with('user:id,name')
                ->orderBy('hostname')
                ->limit(100)
                ->get(['id', 'hostname', 'brand', 'model', 'type', 'user_id'])
                ->mapWithKeys(function (Device $device): array {
                    $assignedUser = $device->user;
                    $userLabel = $assignedUser instanceof User ? $assignedUser->name : 'Belum di-assign';

                    return [$device->id => $device->display_name.' ('.$userLabel.')'];
                })
                ->all();
        }

        $options = [];

        $myDevices = Device::query()
            ->where('user_id', $userId)
            ->orderBy('hostname')
            ->limit(50)
            ->get(['id', 'hostname', 'brand', 'model', 'type']);

        if ($myDevices->isNotEmpty()) {
            $options['Perangkat Saya'] = self::formatDeviceOptions($myDevices);
        }

        $sharedDevices = Device::query()
            ->whereNull('user_id')
            ->orderBy('hostname')
            ->limit(50)
            ->get(['id', 'hostname', 'brand', 'model', 'type']);

        if ($sharedDevices->isNotEmpty()) {
            $options['Perangkat Bersama'] = self::formatDeviceOptions($sharedDevices);
        }

        return $options;
    }

    private static function formatDeviceOptions($devices): array
    {
        return $devices
            ->mapWithKeys(fn (Device $device) => [
                $device->id => $device->display_name.' ('.DeviceType::tryLabel($device->type).')',
            ])
            ->all();
    }
}
