<?php

namespace App\Filament\Resources;

use App\Filament\Resources\DeviceAttributeResource\Pages;
use App\Models\DeviceAttribute;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Str;

class DeviceAttributeResource extends Resource implements HasShieldPermissions
{
    protected static ?string $model = DeviceAttribute::class;

    protected static ?string $navigationIcon = 'heroicon-o-adjustments-horizontal';

    protected static ?string $navigationGroup = 'Inventory';

    protected static ?int $navigationSort = 2;

    protected static ?string $navigationLabel = 'Device Attributes';

    protected static ?string $modelLabel = 'Device Attribute';

    public static function getPermissionPrefixes(): array
    {
        return [
            'view',
            'view_any',
            'create',
            'update',
            'delete',
            'delete_any',
        ];
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Attribute Information')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->required()
                            ->maxLength(255)
                            ->live(onBlur: true)
                            ->afterStateUpdated(fn (Forms\Set $set, ?string $state) => $set('slug', Str::slug($state)))
                            ->placeholder('e.g., GPU, Monitor Size, License Key'),

                        Forms\Components\TextInput::make('slug')
                            ->required()
                            ->maxLength(255)
                            ->unique(ignoreRecord: true)
                            ->helperText('Auto-generated from name'),

                        Forms\Components\Select::make('type')
                            ->options([
                                'text' => 'Text',
                                'number' => 'Number',
                                'select' => 'Dropdown Select',
                                'boolean' => 'Yes/No Toggle',
                                'date' => 'Date',
                                'textarea' => 'Text Area',
                            ])
                            ->required()
                            ->default('text')
                            ->live()
                            ->helperText('Choose the input type for this attribute'),

                        Forms\Components\TextInput::make('sort_order')
                            ->numeric()
                            ->default(0)
                            ->helperText('Lower numbers appear first'),
                    ])->columns(2),

                Forms\Components\Section::make('Dropdown Options')
                    ->schema([
                        Forms\Components\TagsInput::make('options')
                            ->placeholder('Add option and press Enter')
                            ->helperText('Enter each option for the dropdown'),
                    ])
                    ->visible(fn (Forms\Get $get) => $get('type') === 'select'),

                Forms\Components\Section::make('Settings')
                    ->schema([
                        Forms\Components\Toggle::make('is_required')
                            ->label('Required Field')
                            ->helperText('If enabled, this field must be filled when creating/editing a device'),

                        Forms\Components\Toggle::make('is_active')
                            ->label('Active')
                            ->default(true)
                            ->helperText('Inactive attributes will not appear in device forms'),
                    ])->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('slug')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('type')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'text' => 'gray',
                        'number' => 'info',
                        'select' => 'warning',
                        'boolean' => 'success',
                        'date' => 'primary',
                        'textarea' => 'gray',
                        default => 'gray',
                    }),

                Tables\Columns\IconColumn::make('is_required')
                    ->label('Required')
                    ->boolean(),

                Tables\Columns\IconColumn::make('is_active')
                    ->label('Active')
                    ->boolean(),

                Tables\Columns\TextColumn::make('sort_order')
                    ->label('Order')
                    ->sortable(),

                Tables\Columns\TextColumn::make('values_count')
                    ->label('Used In')
                    ->counts('values')
                    ->suffix(' devices'),

                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('type')
                    ->options([
                        'text' => 'Text',
                        'number' => 'Number',
                        'select' => 'Dropdown Select',
                        'boolean' => 'Yes/No Toggle',
                        'date' => 'Date',
                        'textarea' => 'Text Area',
                    ]),

                Tables\Filters\TernaryFilter::make('is_active')
                    ->label('Active Status'),

                Tables\Filters\TernaryFilter::make('is_required')
                    ->label('Required Status'),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('sort_order')
            ->reorderable('sort_order');
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Section::make('Attribute Information')->schema([
                    TextEntry::make('name'),
                    TextEntry::make('slug'),
                    TextEntry::make('type')->badge(),
                    TextEntry::make('sort_order')->label('Sort Order'),
                ])->columns(2),

                Section::make('Options')->schema([
                    TextEntry::make('options')
                        ->badge()
                        ->separator(',')
                        ->default('No options'),
                ])->visible(fn ($record) => $record->type === 'select'),

                Section::make('Settings')->schema([
                    TextEntry::make('is_required')
                        ->label('Required')
                        ->badge()
                        ->formatStateUsing(fn ($state) => $state ? 'Yes' : 'No')
                        ->color(fn ($state) => $state ? 'success' : 'gray'),
                    TextEntry::make('is_active')
                        ->label('Active')
                        ->badge()
                        ->formatStateUsing(fn ($state) => $state ? 'Yes' : 'No')
                        ->color(fn ($state) => $state ? 'success' : 'gray'),
                ])->columns(2),
            ]);
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
            'index' => Pages\ListDeviceAttributes::route('/'),
            'create' => Pages\CreateDeviceAttribute::route('/create'),
            'view' => Pages\ViewDeviceAttribute::route('/{record}'),
            'edit' => Pages\EditDeviceAttribute::route('/{record}/edit'),
        ];
    }
}
