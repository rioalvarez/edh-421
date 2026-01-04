<?php

namespace App\Filament\Resources;

use App\Filament\Exports\DeviceExporter;
use App\Filament\Imports\DeviceImporter;
use App\Filament\Resources\DeviceResource\Pages;
use App\Filament\Resources\DeviceResource\RelationManagers;
use App\Models\Device;
use App\Models\DeviceAttribute;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Actions\ExportAction;
use Filament\Tables\Actions\ImportAction;
use Filament\Tables\Table;

class DeviceResource extends Resource implements HasShieldPermissions
{
    protected static ?string $model = Device::class;

    protected static ?string $navigationIcon = 'heroicon-o-computer-desktop';

    protected static ?string $navigationGroup = 'Inventory';

    protected static ?int $navigationSort = 1;

    protected static ?string $navigationLabel = 'Devices';

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
                Forms\Components\Section::make('Device Information')
                    ->schema([
                        Forms\Components\Select::make('type')
                            ->options([
                                'laptop' => 'Laptop',
                                'desktop' => 'Desktop',
                                'all-in-one' => 'All-in-One',
                                'workstation' => 'Workstation',
                            ])
                            ->required()
                            ->default('desktop'),

                        Forms\Components\Select::make('user_id')
                            ->label('Assigned To')
                            ->relationship('user', 'name')
                            ->searchable()
                            ->preload()
                            ->nullable()
                            ->helperText('Leave empty if device is not assigned'),

                        Forms\Components\TextInput::make('hostname')
                            ->maxLength(255)
                            ->placeholder('e.g., PC-FINANCE-01'),

                        Forms\Components\TextInput::make('ip_address')
                            ->label('IP Address')
                            ->maxLength(45)
                            ->placeholder('e.g., 192.168.1.100'),

                        Forms\Components\TextInput::make('mac_address')
                            ->label('MAC Address')
                            ->maxLength(17)
                            ->placeholder('e.g., 00:1A:2B:3C:4D:5E'),

                        Forms\Components\TextInput::make('brand')
                            ->maxLength(255)
                            ->placeholder('e.g., Dell, HP, Lenovo'),

                        Forms\Components\TextInput::make('model')
                            ->maxLength(255)
                            ->placeholder('e.g., Latitude 5520'),

                        Forms\Components\TextInput::make('serial_number')
                            ->label('Serial Number')
                            ->maxLength(255)
                            ->unique(ignoreRecord: true)
                            ->placeholder('e.g., ABC123XYZ'),

                        Forms\Components\TextInput::make('asset_tag')
                            ->label('Asset Tag')
                            ->maxLength(255)
                            ->unique(ignoreRecord: true)
                            ->placeholder('e.g., AST-2024-001'),

                        Forms\Components\TextInput::make('location')
                            ->maxLength(255)
                            ->placeholder('e.g., Office Floor 2, Room A'),
                    ])->columns(2),

                Forms\Components\Section::make('System Specifications')
                    ->schema([
                        Forms\Components\TextInput::make('os')
                            ->label('Operating System')
                            ->maxLength(255)
                            ->placeholder('e.g., Windows 11 Pro'),

                        Forms\Components\TextInput::make('os_version')
                            ->label('OS Version')
                            ->maxLength(255)
                            ->placeholder('e.g., 22H2'),

                        Forms\Components\TextInput::make('processor')
                            ->maxLength(255)
                            ->placeholder('e.g., Intel Core i7-1165G7'),

                        Forms\Components\TextInput::make('ram')
                            ->label('RAM')
                            ->maxLength(255)
                            ->placeholder('e.g., 16GB DDR4'),

                        Forms\Components\Select::make('storage_type')
                            ->options([
                                'SSD' => 'SSD',
                                'HDD' => 'HDD',
                                'NVMe' => 'NVMe',
                                'Hybrid' => 'Hybrid',
                            ])
                            ->placeholder('Select storage type'),

                        Forms\Components\TextInput::make('storage_capacity')
                            ->label('Storage Capacity')
                            ->maxLength(255)
                            ->placeholder('e.g., 512GB'),
                    ])->columns(2),

                Forms\Components\Section::make('Status & Dates')
                    ->schema([
                        Forms\Components\Select::make('condition')
                            ->options([
                                'excellent' => 'Excellent',
                                'good' => 'Good',
                                'fair' => 'Fair',
                                'poor' => 'Poor',
                                'broken' => 'Broken',
                            ])
                            ->default('good')
                            ->required(),

                        Forms\Components\Select::make('status')
                            ->options([
                                'active' => 'Active',
                                'inactive' => 'Inactive',
                                'maintenance' => 'Maintenance',
                                'retired' => 'Retired',
                            ])
                            ->default('active')
                            ->required(),

                        Forms\Components\DatePicker::make('purchase_date')
                            ->label('Purchase Date'),

                        Forms\Components\DatePicker::make('warranty_expiry')
                            ->label('Warranty Expiry'),
                    ])->columns(2),

                Forms\Components\Section::make('Additional Attributes')
                    ->schema(function () {
                        $attributes = DeviceAttribute::active()->ordered()->get();
                        $fields = [];

                        foreach ($attributes as $attribute) {
                            $field = match ($attribute->type) {
                                'text' => Forms\Components\TextInput::make("dynamic_attributes.{$attribute->slug}")
                                    ->label($attribute->name)
                                    ->required($attribute->is_required),
                                'number' => Forms\Components\TextInput::make("dynamic_attributes.{$attribute->slug}")
                                    ->label($attribute->name)
                                    ->numeric()
                                    ->required($attribute->is_required),
                                'textarea' => Forms\Components\Textarea::make("dynamic_attributes.{$attribute->slug}")
                                    ->label($attribute->name)
                                    ->required($attribute->is_required),
                                'select' => Forms\Components\Select::make("dynamic_attributes.{$attribute->slug}")
                                    ->label($attribute->name)
                                    ->options(collect($attribute->options ?? [])->mapWithKeys(fn ($opt) => [$opt => $opt])->toArray())
                                    ->required($attribute->is_required),
                                'boolean' => Forms\Components\Toggle::make("dynamic_attributes.{$attribute->slug}")
                                    ->label($attribute->name)
                                    ->required($attribute->is_required),
                                'date' => Forms\Components\DatePicker::make("dynamic_attributes.{$attribute->slug}")
                                    ->label($attribute->name)
                                    ->required($attribute->is_required),
                                default => Forms\Components\TextInput::make("dynamic_attributes.{$attribute->slug}")
                                    ->label($attribute->name)
                                    ->required($attribute->is_required),
                            };

                            $fields[] = $field;
                        }

                        return $fields;
                    })
                    ->columns(2)
                    ->visible(fn () => DeviceAttribute::active()->exists()),

                Forms\Components\Section::make('Notes')
                    ->schema([
                        Forms\Components\Textarea::make('notes')
                            ->columnSpanFull()
                            ->rows(3)
                            ->placeholder('Additional notes about this device...'),
                    ])->collapsible(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('hostname')
                    ->label('Hostname')
                    ->searchable()
                    ->sortable()
                    ->default('-'),

                Tables\Columns\TextColumn::make('type')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'laptop' => 'info',
                        'desktop' => 'success',
                        'all-in-one' => 'warning',
                        'workstation' => 'primary',
                        default => 'gray',
                    }),

                Tables\Columns\TextColumn::make('user.name')
                    ->label('Assigned To')
                    ->searchable()
                    ->sortable()
                    ->default('Unassigned')
                    ->badge()
                    ->color(fn ($state) => $state === 'Unassigned' ? 'gray' : 'success'),

                Tables\Columns\TextColumn::make('ip_address')
                    ->label('IP Address')
                    ->searchable()
                    ->toggleable(),

                Tables\Columns\TextColumn::make('brand')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('model')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('serial_number')
                    ->label('Serial No.')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('os')
                    ->label('OS')
                    ->limit(20)
                    ->toggleable(),

                Tables\Columns\TextColumn::make('ram')
                    ->label('RAM')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('condition')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'excellent' => 'success',
                        'good' => 'info',
                        'fair' => 'warning',
                        'poor' => 'danger',
                        'broken' => 'danger',
                        default => 'gray',
                    }),

                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'active' => 'success',
                        'inactive' => 'gray',
                        'maintenance' => 'warning',
                        'retired' => 'danger',
                        default => 'gray',
                    }),

                Tables\Columns\TextColumn::make('warranty_expiry')
                    ->label('Warranty')
                    ->date()
                    ->sortable()
                    ->color(fn ($record) => $record?->isWarrantyExpired() ? 'danger' : null)
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('type')
                    ->options([
                        'laptop' => 'Laptop',
                        'desktop' => 'Desktop',
                        'all-in-one' => 'All-in-One',
                        'workstation' => 'Workstation',
                    ]),

                Tables\Filters\SelectFilter::make('status')
                    ->options([
                        'active' => 'Active',
                        'inactive' => 'Inactive',
                        'maintenance' => 'Maintenance',
                        'retired' => 'Retired',
                    ]),

                Tables\Filters\SelectFilter::make('condition')
                    ->options([
                        'excellent' => 'Excellent',
                        'good' => 'Good',
                        'fair' => 'Fair',
                        'poor' => 'Poor',
                        'broken' => 'Broken',
                    ]),

                Tables\Filters\SelectFilter::make('user_id')
                    ->label('Assigned To')
                    ->relationship('user', 'name')
                    ->searchable()
                    ->preload(),

                Tables\Filters\TernaryFilter::make('assigned')
                    ->label('Assignment Status')
                    ->placeholder('All')
                    ->trueLabel('Assigned')
                    ->falseLabel('Unassigned')
                    ->queries(
                        true: fn ($query) => $query->whereNotNull('user_id'),
                        false: fn ($query) => $query->whereNull('user_id'),
                    ),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->headerActions([
                ExportAction::make()
                    ->exporter(DeviceExporter::class)
                    ->label('Export')
                    ->icon('heroicon-o-arrow-down-tray'),
                ImportAction::make()
                    ->importer(DeviceImporter::class)
                    ->label('Import')
                    ->icon('heroicon-o-arrow-up-tray'),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('created_at', 'desc');
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Section::make('Device Information')->schema([
                    TextEntry::make('type')->badge(),
                    TextEntry::make('user.name')->label('Assigned To')->default('Unassigned'),
                    TextEntry::make('hostname')->default('-'),
                    TextEntry::make('ip_address')->label('IP Address')->default('-'),
                    TextEntry::make('mac_address')->label('MAC Address')->default('-'),
                    TextEntry::make('brand')->default('-'),
                    TextEntry::make('model')->default('-'),
                    TextEntry::make('serial_number')->label('Serial Number')->default('-'),
                    TextEntry::make('asset_tag')->label('Asset Tag')->default('-'),
                    TextEntry::make('location')->default('-'),
                ])->columns(2),

                Section::make('System Specifications')->schema([
                    TextEntry::make('os')->label('Operating System')->default('-'),
                    TextEntry::make('os_version')->label('OS Version')->default('-'),
                    TextEntry::make('processor')->default('-'),
                    TextEntry::make('ram')->label('RAM')->default('-'),
                    TextEntry::make('storage_type')->default('-'),
                    TextEntry::make('storage_capacity')->default('-'),
                ])->columns(2),

                Section::make('Status & Dates')->schema([
                    TextEntry::make('condition')->badge(),
                    TextEntry::make('status')->badge(),
                    TextEntry::make('purchase_date')->date()->default('-'),
                    TextEntry::make('warranty_expiry')->date()->default('-'),
                ])->columns(2),

                Section::make('Notes')->schema([
                    TextEntry::make('notes')
                        ->columnSpanFull()
                        ->default('No notes'),
                ])->collapsible(),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            RelationManagers\AttributeValuesRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListDevices::route('/'),
            'create' => Pages\CreateDevice::route('/create'),
            'view' => Pages\ViewDevice::route('/{record}'),
            'edit' => Pages\EditDevice::route('/{record}/edit'),
        ];
    }
}
