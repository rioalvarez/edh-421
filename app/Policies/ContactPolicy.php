<?php

namespace App\Policies;

use App\Models\Contact;
use App\Models\User;
use App\Policies\Concerns\ChecksPolicyPermissions;
use App\Policies\Concerns\HasSuperAdminBypass;
use Illuminate\Auth\Access\HandlesAuthorization;

class ContactPolicy
{
    use ChecksPolicyPermissions;
    use HandlesAuthorization;
    use HasSuperAdminBypass;

    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user): bool
    {
        return $this->canPerform($user, 'view_any_contact');
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, Contact $contact): bool
    {
        return $this->canPerform($user, 'view_contact');
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $this->canPerform($user, 'create_contact');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, Contact $contact): bool
    {
        return $this->canPerform($user, 'update_contact');
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, Contact $contact): bool
    {
        return $this->canPerform($user, 'delete_contact');
    }

    /**
     * Determine whether the user can bulk delete.
     */
    public function deleteAny(User $user): bool
    {
        return $this->canPerform($user, 'delete_any_contact');
    }

    /**
     * Determine whether the user can permanently delete.
     */
    public function forceDelete(User $user, Contact $contact): bool
    {
        return $this->denyUnsupportedAbility();
    }

    /**
     * Determine whether the user can permanently bulk delete.
     */
    public function forceDeleteAny(User $user): bool
    {
        return $this->denyUnsupportedAbility();
    }

    /**
     * Determine whether the user can restore.
     */
    public function restore(User $user, Contact $contact): bool
    {
        return $this->denyUnsupportedAbility();
    }

    /**
     * Determine whether the user can bulk restore.
     */
    public function restoreAny(User $user): bool
    {
        return $this->denyUnsupportedAbility();
    }

    /**
     * Determine whether the user can replicate.
     */
    public function replicate(User $user, Contact $contact): bool
    {
        return $this->denyUnsupportedAbility();
    }

    /**
     * Determine whether the user can reorder.
     */
    public function reorder(User $user): bool
    {
        return $this->denyUnsupportedAbility();
    }
}
