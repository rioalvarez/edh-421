<?php

namespace App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource\Schemas;

use App\Models\User;
use Filament\Forms;
use Filament\Forms\Components\SpatieMediaLibraryFileUpload;
use Filament\Forms\Form;
use Illuminate\Support\Str;

class ArticleForm
{
    public static function configure(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Split::make([
                    Forms\Components\Section::make()
                        ->schema([
                            Forms\Components\TextInput::make('title')
                                ->label('Judul')
                                ->required()
                                ->maxLength(255)
                                ->live(onBlur: true)
                                ->afterStateUpdated(fn (Forms\Set $set, ?string $state) => $set('slug', Str::slug($state))),

                            Forms\Components\TextInput::make('slug')
                                ->label('Slug')
                                ->required()
                                ->maxLength(255)
                                ->unique(ignoreRecord: true),

                            Forms\Components\RichEditor::make('content')
                                ->label('Konten')
                                ->required()
                                ->columnSpanFull()
                                ->fileAttachmentsDisk('public')
                                ->fileAttachmentsDirectory('articles/content')
                                ->fileAttachmentsVisibility('public')
                                ->toolbarButtons([
                                    'attachFiles',
                                    'bold',
                                    'italic',
                                    'underline',
                                    'strike',
                                    'link',
                                    'orderedList',
                                    'bulletList',
                                    'h2',
                                    'h3',
                                    'blockquote',
                                    'codeBlock',
                                    'redo',
                                    'undo',
                                ]),
                        ]),

                    Forms\Components\Section::make()
                        ->schema([
                            Forms\Components\Select::make('status')
                                ->label('Status')
                                ->options([
                                    'draft' => 'Draf',
                                    'published' => 'Terbit',
                                    'archived' => 'Arsip',
                                ])
                                ->default('draft')
                                ->required()
                                ->native(false),

                            Forms\Components\DateTimePicker::make('published_at')
                                ->label('Tanggal Terbit')
                                ->nullable(),

                            Forms\Components\Select::make('category_id')
                                ->label('Kategori')
                                ->relationship('category', 'name')
                                ->searchable()
                                ->preload()
                                ->createOptionForm([
                                    Forms\Components\TextInput::make('name')
                                        ->label('Nama')
                                        ->required()
                                        ->live(onBlur: true)
                                        ->afterStateUpdated(fn (Forms\Set $set, ?string $state) => $set('slug', Str::slug($state))),
                                    Forms\Components\TextInput::make('slug')
                                        ->label('Slug')
                                        ->required(),
                                    Forms\Components\Toggle::make('is_active')
                                        ->label('Aktif')
                                        ->default(true),
                                ])
                                ->required(),

                            Forms\Components\Select::make('user_id')
                                ->label('Penulis (User)')
                                ->relationship('author', 'name')
                                ->searchable()
                                ->preload()
                                ->live()
                                ->afterStateUpdated(function (Forms\Set $set, $state) {
                                    if (! $state) {
                                        return;
                                    }

                                    $user = User::find($state);

                                    if ($user) {
                                        $set('author_name', $user->name);
                                    }
                                })
                                ->nullable(),

                            Forms\Components\TextInput::make('author_name')
                                ->label('Alias Penulis')
                                ->required()
                                ->maxLength(255)
                                ->helperText('Nama yang ditampilkan jika berbeda dengan user.'),

                            SpatieMediaLibraryFileUpload::make('featured_image')
                                ->label('Gambar Utama')
                                ->collection('featured')
                                ->image()
                                ->imageEditor()
                                ->columnSpanFull(),
                        ])
                        ->grow(false),
                ])
                    ->from('md')
                    ->columnSpanFull(),
            ]);
    }
}
