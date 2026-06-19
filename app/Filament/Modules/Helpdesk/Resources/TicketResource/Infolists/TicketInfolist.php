<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\Infolists;

use App\Enums\DeviceType;
use App\Enums\TicketCategory;
use App\Enums\TicketPriority;
use App\Enums\TicketStatus;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;

class TicketInfolist
{
    public static function configure(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Section::make('Informasi Tiket')
                    ->schema([
                        TextEntry::make('ticket_number')
                            ->label('Nomor Tiket')
                            ->weight('bold')
                            ->copyable(),
                        TextEntry::make('user.name')
                            ->label('Pelapor'),
                        TextEntry::make('category')
                            ->label('Layanan')
                            ->badge()
                            ->color(fn ($state) => TicketCategory::tryColor($state))
                            ->formatStateUsing(fn ($state) => TicketCategory::tryLabel($state)),
                        TextEntry::make('priority')
                            ->label('Prioritas')
                            ->badge()
                            ->color(fn ($state) => TicketPriority::tryColor($state))
                            ->formatStateUsing(fn ($state) => TicketPriority::tryLabel($state)),
                        TextEntry::make('status')
                            ->label('Status')
                            ->badge()
                            ->color(fn ($state) => TicketStatus::tryColor($state))
                            ->formatStateUsing(fn ($state) => TicketStatus::tryLabel($state)),
                        TextEntry::make('created_at')
                            ->label('Dibuat')
                            ->dateTime('d M Y H:i'),
                    ])->columns(3),

                Section::make('Detail Masalah')
                    ->schema([
                        TextEntry::make('subject')
                            ->label('Subjek'),
                        TextEntry::make('description')
                            ->label('Deskripsi')
                            ->html()
                            ->columnSpanFull(),
                    ]),

                Section::make('Lampiran')
                    ->schema([
                        TextEntry::make('attachments')
                            ->label('')
                            ->state(function ($record) {
                                return $record->attachments->count() > 0 ? 'has_attachments' : null;
                            })
                            ->formatStateUsing(fn ($record) => view('filament.resources.ticket-resource.partials.attachments', ['attachments' => $record->attachments]))
                            ->html()
                            ->columnSpanFull(),
                    ])
                    ->visible(fn ($record) => $record->attachments->count() > 0),

                Section::make('Perangkat Terkait')
                    ->schema([
                        TextEntry::make('is_external_device')
                            ->label('Jenis Perangkat')
                            ->badge()
                            ->formatStateUsing(fn ($state) => $state ? 'Perangkat Luar/Lainnya' : 'Perangkat Terdaftar')
                            ->color(fn ($state) => $state ? 'warning' : 'success'),
                        TextEntry::make('device.display_name')
                            ->label('Perangkat')
                            ->default('Tidak ada')
                            ->visible(fn ($record) => ! $record->is_external_device),
                        TextEntry::make('device.type')
                            ->label('Tipe')
                            ->badge()
                            ->default('-')
                            ->formatStateUsing(fn ($state) => DeviceType::tryLabel($state))
                            ->color(fn ($state) => DeviceType::tryColor($state))
                            ->visible(fn ($record) => ! $record->is_external_device),
                        TextEntry::make('device.serial_number')
                            ->label('Serial Number')
                            ->default('-')
                            ->visible(fn ($record) => ! $record->is_external_device),
                        TextEntry::make('device.ip_address')
                            ->label('IP Address')
                            ->default('-')
                            ->visible(fn ($record) => ! $record->is_external_device),
                    ])->columns(4)
                    ->visible(fn ($record) => $record->device_id !== null || $record->is_external_device),

                Section::make('Penanganan')
                    ->schema([
                        TextEntry::make('assignedTo.name')
                            ->label('Ditugaskan Ke')
                            ->default('Belum ditugaskan'),
                        TextEntry::make('resolved_at')
                            ->label('Diselesaikan')
                            ->dateTime('d M Y H:i')
                            ->placeholder('-'),
                        TextEntry::make('closed_at')
                            ->label('Ditutup')
                            ->dateTime('d M Y H:i')
                            ->placeholder('-'),
                        TextEntry::make('resolution_notes')
                            ->label('Catatan Penyelesaian')
                            ->default('Belum ada')
                            ->columnSpanFull(),
                    ])->columns(3),
            ]);
    }
}
