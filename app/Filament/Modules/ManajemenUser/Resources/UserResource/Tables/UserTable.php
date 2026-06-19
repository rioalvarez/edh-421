<?php

namespace App\Filament\Modules\ManajemenUser\Resources\UserResource\Tables;

use App\Filament\Exports\UserExporter;
use App\Filament\Imports\UserImporter;
use App\Models\User;
use Filament\Forms\Components\Select;
use Filament\Notifications\Notification;
use Filament\Support\Enums\FontWeight;
use Filament\Tables;
use Filament\Tables\Actions\Action;
use Filament\Tables\Actions\ExportAction;
use Filament\Tables\Actions\ExportBulkAction;
use Filament\Tables\Actions\ImportAction;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use Spatie\Permission\Models\Role;

class UserTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\Layout\Split::make([
                    Tables\Columns\ImageColumn::make('avatar_url')
                        ->searchable()
                        ->circular()
                        ->grow(false)
                        ->getStateUsing(fn ($record) => $record->avatar_url
                            ? $record->avatar_url
                            : 'https://ui-avatars.com/api/?name='.urlencode($record->name)),
                    Tables\Columns\Layout\Stack::make([
                        Tables\Columns\TextColumn::make('name')
                            ->label('Nama')
                            ->searchable()
                            ->weight(FontWeight::Bold),
                        Tables\Columns\Layout\Split::make([
                            Tables\Columns\TextColumn::make('nip')
                                ->label('NIP')
                                ->searchable()
                                ->icon('heroicon-o-identification')
                                ->color('gray')
                                ->size('sm')
                                ->grow(false),
                            Tables\Columns\ViewColumn::make('copy_nip')
                                ->view('filament.tables.columns.copy-nip-button')
                                ->viewData(fn (User $record): array => [
                                    'nip' => $record->nip,
                                ])
                                ->grow(false),
                        ])->from('sm'),
                    ])->space(1),
                    Tables\Columns\Layout\Stack::make([
                        Tables\Columns\TextColumn::make('roles.name')
                            ->label('Role')
                            ->searchable()
                            ->icon('heroicon-o-shield-check')
                            ->grow(false),
                        Tables\Columns\TextColumn::make('phone_number')
                            ->label('No. HP')
                            ->icon('heroicon-m-phone')
                            ->searchable()
                            ->placeholder('-')
                            ->grow(false),
                        Tables\Columns\TextColumn::make('email')
                            ->label('Email')
                            ->icon('heroicon-m-envelope')
                            ->searchable()
                            ->placeholder('-')
                            ->grow(false),
                    ])->alignStart()->visibleFrom('lg')->space(1),
                ]),
            ])
            ->filters([
                SelectFilter::make('roles')
                    ->label('Role')
                    ->relationship('roles', 'name')
                    ->multiple()
                    ->preload(),
            ])
            ->defaultSort('name')
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Action::make('Set Role')
                    ->label('Atur Role')
                    ->icon('heroicon-m-adjustments-vertical')
                    ->form([
                        Select::make('roles')
                            ->label('Role')
                            ->options(Role::pluck('name', 'id'))
                            ->multiple()
                            ->required()
                            ->searchable()
                            ->preload()
                            ->default(fn ($record) => $record->roles->pluck('id')->toArray()),
                    ])
                    ->action(function (array $data, User $record) {
                        $roles = Role::whereIn('id', $data['roles'])->get();
                        $record->syncRoles($roles);

                        Notification::make()
                            ->title('Role berhasil diperbarui')
                            ->body("Role untuk {$record->name} telah diperbarui.")
                            ->success()
                            ->send();
                    }),
                Tables\Actions\DeleteAction::make(),
            ])
            ->headerActions([
                ExportAction::make()
                    ->exporter(UserExporter::class),
                ImportAction::make()
                    ->importer(UserImporter::class),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\BulkAction::make('assignRoles')
                        ->label('Atur Role')
                        ->icon('heroicon-o-shield-check')
                        ->color('primary')
                        ->form([
                            Select::make('roles')
                                ->label('Pilih Role')
                                ->options(Role::pluck('name', 'id'))
                                ->multiple()
                                ->required()
                                ->searchable()
                                ->preload(),
                            Select::make('mode')
                                ->label('Mode')
                                ->options([
                                    'sync' => 'Ganti semua role (Replace)',
                                    'attach' => 'Tambahkan role (Append)',
                                ])
                                ->default('sync')
                                ->required()
                                ->helperText('Replace: Hapus role lama, ganti dengan yang baru. Append: Tambahkan role tanpa menghapus yang lama.'),
                        ])
                        ->action(function (array $data, $records) {
                            $roles = Role::whereIn('id', $data['roles'])->get();
                            $count = 0;

                            foreach ($records as $user) {
                                if ($data['mode'] === 'sync') {
                                    $user->syncRoles($roles);
                                } else {
                                    $user->assignRole($roles);
                                }
                                $count++;
                            }

                            Notification::make()
                                ->title('Role berhasil diperbarui')
                                ->body("{$count} user telah diperbarui.")
                                ->success()
                                ->send();
                        })
                        ->deselectRecordsAfterCompletion(),
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
                ExportBulkAction::make()
                    ->exporter(UserExporter::class),
            ]);
    }
}
