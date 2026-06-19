<?php

namespace App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource\Infolists;

use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\SpatieMediaLibraryImageEntry;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;

class ArticleInfolist
{
    public static function configure(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Section::make('Informasi Artikel')->schema([
                    TextEntry::make('title')->label('Judul'),
                    TextEntry::make('slug')->label('Slug'),
                    TextEntry::make('author_name')->label('Penulis'),
                    TextEntry::make('category.name')->label('Kategori')->badge(),
                    TextEntry::make('status')
                        ->label('Status')
                        ->badge()
                        ->formatStateUsing(fn (string $state): string => match ($state) {
                            'published' => 'Terbit',
                            'draft' => 'Draf',
                            'archived' => 'Arsip',
                            default => $state,
                        }),
                    TextEntry::make('views')->label('Dilihat'),
                    TextEntry::make('published_at')->label('Diterbitkan Pada')->dateTime(),
                ])->columns(2),

                Section::make('Konten')->schema([
                    TextEntry::make('content')
                        ->label('Konten')
                        ->html()
                        ->columnSpanFull(),
                ]),

                Section::make('Gambar Utama')->schema([
                    SpatieMediaLibraryImageEntry::make('featured_image')
                        ->label('Gambar Utama')
                        ->collection('featured')
                        ->columnSpanFull(),
                ])->collapsible(),
            ]);
    }
}
