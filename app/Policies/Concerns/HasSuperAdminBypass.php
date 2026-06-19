<?php

namespace App\Policies\Concerns;

use App\Models\User;

trait HasSuperAdminBypass
{
    public function before(User $user, string $ability): ?bool
    {
        return $user->isSuperAdmin() ? true : null;
    }
}
