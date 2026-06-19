<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\RelationManagers;

use App\Enums\TicketStatus;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;

class ResponsesRelationManager extends RelationManager
{
    protected static string $relationship = 'responses';

    protected static ?string $title = 'Tanggapan';

    protected static ?string $modelLabel = 'Tanggapan';

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\RichEditor::make('message')
                    ->label('Pesan')
                    ->required()
                    ->toolbarButtons([
                        'bold',
                        'italic',
                        'underline',
                        'bulletList',
                        'orderedList',
                    ])
                    ->columnSpanFull(),

                Forms\Components\Toggle::make('is_internal_note')
                    ->label('Catatan Internal')
                    ->helperText('Jika diaktifkan, pesan ini hanya terlihat oleh admin/IT')
                    ->default(false)
                    ->visible(fn () => auth()->user()->isSuperAdmin()),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('message')
            ->columns([
                Tables\Columns\TextColumn::make('user.name')
                    ->label('Dari')
                    ->sortable()
                    ->icon(fn ($record) => $record->isFromAdmin() ? 'heroicon-o-shield-check' : 'heroicon-o-user')
                    ->iconColor(fn ($record) => $record->isFromAdmin() ? 'success' : 'gray'),

                Tables\Columns\TextColumn::make('message')
                    ->label('Pesan')
                    ->html()
                    ->limit(100)
                    ->wrap(),

                Tables\Columns\IconColumn::make('is_internal_note')
                    ->label('Internal')
                    ->boolean()
                    ->trueIcon('heroicon-o-lock-closed')
                    ->falseIcon('heroicon-o-lock-open')
                    ->trueColor('warning')
                    ->falseColor('gray'),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Waktu')
                    ->dateTime('d M Y H:i')
                    ->sortable(),
            ])
            ->filters([
                Tables\Filters\TernaryFilter::make('is_internal_note')
                    ->label('Catatan Internal')
                    ->trueLabel('Hanya Internal')
                    ->falseLabel('Hanya Publik')
                    ->placeholder('Semua'),
            ])
            ->headerActions([
                Tables\Actions\CreateAction::make()
                    ->label('Tambah Tanggapan')
                    ->mutateFormDataUsing(function (array $data): array {
                        $data['user_id'] = auth()->id();

                        return $data;
                    })
                    ->after(function ($record) {
                        // Update ticket status to in_progress if it's open
                        $ticket = $this->getOwnerRecord();
                        if ($ticket->status === TicketStatus::Open->value && auth()->user()->isSuperAdmin()) {
                            $ticket->update(['status' => TicketStatus::InProgress->value]);
                        }
                    }),
            ])
            ->actions([
                Tables\Actions\EditAction::make()
                    ->visible(fn ($record) => $record->user_id === auth()->id()),
                Tables\Actions\DeleteAction::make()
                    ->visible(fn ($record) => $record->user_id === auth()->id() || auth()->user()->isSuperAdmin()),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('created_at', 'asc')
            ->modifyQueryUsing(function ($query) {
                // Hide internal notes from non-admin users
                if (! auth()->user()->isSuperAdmin()) {
                    $query->where('is_internal_note', false);
                }
            });
    }

    public function isReadOnly(): bool
    {
        // Allow responses even when viewing ticket
        return false;
    }
}
