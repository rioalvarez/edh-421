<?php

namespace App\Filament\Modules\ManajemenUser\Resources;

use App\Filament\Concerns\HasModuleNavigationGate;
use App\Filament\Modules\ManajemenUser\Resources\UserResource\Infolists\UserInfolist;
use App\Filament\Modules\ManajemenUser\Resources\UserResource\Pages;
use App\Filament\Modules\ManajemenUser\Resources\UserResource\Schemas\UserForm;
use App\Filament\Modules\ManajemenUser\Resources\UserResource\Tables\UserTable;
use App\Models\User;
use Filament\Forms\Form;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class UserResource extends Resource
{
    use HasModuleNavigationGate;

    protected static ?string $model = User::class;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::USERS_ACCOUNTS;

    protected static ?string $navigationIcon = 'heroicon-o-users';

    protected static ?string $navigationGroup = 'Manajemen User';

    protected static ?string $modelLabel = 'User';

    protected static ?string $pluralModelLabel = 'Daftar User';

    protected static ?int $navigationSort = 1;

    public static function canCreate(): bool
    {
        return true;
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->with(['roles']);
    }

    public static function form(Form $form): Form
    {
        return UserForm::configure($form);
    }

    public static function table(Table $table): Table
    {
        return UserTable::configure($table);
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return UserInfolist::configure($infolist);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListUsers::route('/'),
            'create' => Pages\CreateUser::route('/create'),
            'view' => Pages\ViewUser::route('/{record}'),
            'edit' => Pages\EditUser::route('/{record}/edit'),
        ];
    }
}
