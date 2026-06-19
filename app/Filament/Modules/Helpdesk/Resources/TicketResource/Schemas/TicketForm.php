<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\Schemas;

use App\Enums\TicketCategory;
use App\Enums\TicketPriority;
use App\Enums\TicketStatus;
use App\Filament\Modules\Helpdesk\Resources\TicketResource\Support\TicketDeviceOptions;
use App\Filament\Modules\Helpdesk\Resources\TicketResource\Support\TicketKnowledgeSuggestions;
use App\Models\User;
use App\Settings\ModuleSettings;
use Filament\Forms;
use Filament\Forms\Form;

class TicketForm
{
    public static function configure(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Informasi Tiket')
                    ->schema([
                        Forms\Components\TextInput::make('ticket_number')
                            ->label('Nomor Tiket')
                            ->disabled()
                            ->dehydrated(false)
                            ->visible(fn ($record) => $record !== null),

                        Forms\Components\Select::make('user_id')
                            ->label('Pelapor')
                            ->relationship('user', 'name')
                            ->searchable()
                            ->preload()
                            ->required()
                            ->default(fn () => auth()->id())
                            ->disabled(fn () => ! auth()->user()->isItAdmin())
                            ->dehydrated(true), // Pastikan value tetap terkirim meskipun disabled

                        Forms\Components\Select::make('device_id')
                            ->label('Perangkat Terkait')
                            ->options(fn (Forms\Get $get) => TicketDeviceOptions::forUser($get('user_id')))
                            ->searchable()
                            ->preload()
                            ->nullable()
                            ->reactive()
                            ->helperText('Pilih perangkat yang bermasalah (opsional)')
                            ->disabled(fn ($record, Forms\Get $get) => ($record !== null && ! auth()->user()->isItAdmin()) || $get('is_external_device'))
                            ->dehydrated(true),

                        Forms\Components\Toggle::make('is_external_device')
                            ->label('Perangkat Tidak Terdaftar')
                            ->helperText('Centang jika perangkat tidak terdaftar di sistem (mesin fotokopi, proyektor, perangkat pribadi, dll).')
                            ->reactive()
                            ->afterStateUpdated(fn (Forms\Set $set, $state) => $state ? $set('device_id', null) : null),

                        Forms\Components\Select::make('category')
                            ->label('Layanan')
                            ->options(TicketCategory::serviceOptions())
                            ->required()
                            ->default(TicketCategory::IncidentManagement->value)
                            ->disabled(fn ($record) => $record !== null && ! auth()->user()->isItAdmin())
                            ->dehydrated(true)
                            ->live(),

                        Forms\Components\Select::make('priority')
                            ->label('Prioritas')
                            // Hanya admin yang bisa set prioritas Kritis
                            ->options(fn () => TicketPriority::options(includeCritical: auth()->user()->isItAdmin()))
                            ->required()
                            ->default(TicketPriority::Medium->value),
                    ])->columns(2),

                Forms\Components\Section::make('Detail Masalah')
                    ->schema([
                        Forms\Components\TextInput::make('subject')
                            ->label('Subjek')
                            ->required()
                            ->maxLength(255)
                            ->placeholder('Ringkasan singkat masalah')
                            ->disabled(fn ($record) => $record !== null && ! auth()->user()->isItAdmin())
                            ->dehydrated(true)
                            ->live(debounce: 500),

                        Forms\Components\RichEditor::make('description')
                            ->label('Deskripsi')
                            ->required()
                            ->placeholder('Jelaskan masalah secara detail...')
                            ->toolbarButtons([
                                'bold',
                                'italic',
                                'underline',
                                'bulletList',
                                'orderedList',
                            ])
                            ->columnSpanFull()
                            ->disabled(fn ($record) => $record !== null && ! auth()->user()->isItAdmin())
                            ->dehydrated(true),

                        Forms\Components\FileUpload::make('attachments')
                            ->label('Lampiran Foto/File')
                            ->multiple()
                            ->image()
                            ->imageEditor()
                            ->maxSize(5120) // 5MB
                            ->maxFiles(5)
                            ->disk('public')
                            ->directory('ticket-attachments')
                            ->visibility('public')
                            ->helperText('Upload foto kerusakan atau file pendukung (maks. 5 file, @5MB)')
                            ->columnSpanFull()
                            ->dehydrated(false),
                    ]),

                Forms\Components\Section::make('Artikel KB Terkait')
                    ->schema([
                        Forms\Components\Placeholder::make('kb_suggestions')
                            ->label('')
                            ->content(fn (Forms\Get $get) => TicketKnowledgeSuggestions::render(
                                $get('subject'),
                                $get('category'),
                            ))
                            ->columnSpanFull(),
                    ])
                    ->collapsible()
                    ->visible(fn () => app(ModuleSettings::class)->enable_blog),

                Forms\Components\Section::make('Penanganan')
                    ->schema([
                        Forms\Components\Select::make('assigned_to')
                            ->label('Ditugaskan Ke')
                            ->options(function () {
                                return User::role('Admin')
                                    ->withCount(['assignedTickets as active_tickets' => fn ($q) => $q->whereIn('status', TicketStatus::openValues()),
                                    ])
                                    ->get()
                                    ->mapWithKeys(fn ($u) => [$u->id => "{$u->name} ({$u->active_tickets} aktif)"]);
                            })
                            ->searchable()
                            ->preload()
                            ->nullable()
                            ->helperText('IT Admin yang menangani tiket'),

                        Forms\Components\Select::make('status')
                            ->label('Status')
                            ->options(TicketStatus::options())
                            ->required()
                            ->default(TicketStatus::Open->value)
                            ->reactive(),

                        Forms\Components\Textarea::make('resolution_notes')
                            ->label('Catatan Penyelesaian')
                            ->placeholder('Jelaskan solusi atau tindakan yang diambil...')
                            ->rows(3)
                            ->columnSpanFull()
                            ->visible(fn (Forms\Get $get) => in_array($get('status'), TicketStatus::completedValues(), true)),
                    ])->columns(2)
                    ->visible(fn () => auth()->user()->isItAdmin()),
            ]);
    }
}
