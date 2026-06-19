<?php

namespace App\Policies\Concerns;

use App\Models\User;

trait ChecksPolicyPermissions
{
    protected function canPerform(User $user, string $permission): bool
    {
        return $user->can($permission);
    }

    protected function denyUnsupportedAbility(): bool
    {
        return false;
    }

    protected function ownsRecord(User $user, ?int $ownerId): bool
    {
        return $ownerId !== null && (int) $ownerId === (int) $user->getKey();
    }

    protected function isItAdmin(User $user): bool
    {
        return $user->isItAdmin();
    }
}
