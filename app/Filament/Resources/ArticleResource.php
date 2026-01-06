<?php

namespace App\Filament\Resources;

use App\Filament\Exports\ArticleExporter;
use App\Filament\Imports\ArticleImporter;
use App\Filament\Resources\ArticleResource\Pages;
use App\Models\Article;
use App\Models\User;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;
use Filament\Forms;
use Filament\Forms\Components\SpatieMediaLibraryFileUpload;
use Filament\Forms\Form;
use Filament\Infolists\Components\SpatieMediaLibraryImageEntry;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Actions\ExportAction;
use Filament\Tables\Actions\ImportAction;
use Filament\Tables\Columns\SpatieMediaLibraryImageColumn;
use Filament\Tables\Table;
use Illuminate\Support\Str;

class ArticleResource extends Resource implements HasShieldPermissions
{
    protected static ?string $model = Article::class;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';

    protected static ?string $navigationGroup = 'Content';

    protected static ?int $navigationSort = 1;

    public static function getPermissionPrefixes(): array
    {
        return [
            'view',
            'view_any',
            'create',
            'update',
            'restore',
            'restore_any',
            'replicate',
            'reorder',
            'delete',
            'delete_any',
            'force_delete',
            'force_delete_any',
            'article:create',
            'article:update',
            'article:delete',
            'article:pagination',
            'article:detail',
        ];
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Split::make([
                    // Main Content (Left)
                    Forms\Components\Section::make()
                        ->schema([
                            Forms\Components\TextInput::make('title')
                                ->required()
                                ->maxLength(255)
                                ->live(onBlur: true)
                                ->afterStateUpdated(fn (Forms\Set $set, ?string $state) => $set('slug', Str::slug($state))),

                            Forms\Components\TextInput::make('slug')
                                ->required()
                                ->maxLength(255)
                                ->unique(ignoreRecord: true),

                            Forms\Components\RichEditor::make('content')
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

                    // Sidebar (Right)
                    Forms\Components\Section::make()
                        ->schema([
                            Forms\Components\Select::make('status')
                                ->options([
                                    'draft' => 'Draft',
                                    'published' => 'Published',
                                    'archived' => 'Archived',
                                ])
                                ->default('draft')
                                ->required()
                                ->native(false),

                            Forms\Components\DateTimePicker::make('published_at')
                                ->label('Publish Date')
                                ->nullable(),

                            Forms\Components\Select::make('category_id')
                                ->relationship('category', 'name')
                                ->searchable()
                                ->preload()
                                ->createOptionForm([
                                    Forms\Components\TextInput::make('name')
                                        ->required()
                                        ->live(onBlur: true)
                                        ->afterStateUpdated(fn (Forms\Set $set, ?string $state) => $set('slug', Str::slug($state))),
                                    Forms\Components\TextInput::make('slug')
                                        ->required(),
                                    Forms\Components\Toggle::make('is_active')
                                        ->default(true),
                                ])
                                ->required(),

                            Forms\Components\Select::make('user_id')
                                ->label('Author (User)')
                                ->relationship('author', 'name')
                                ->searchable()
                                ->preload()
                                ->live()
                                ->afterStateUpdated(function (Forms\Set $set, $state) {
                                    if ($state) {
                                        $user = User::find($state);
                                        if ($user) {
                                            $set('author_name', $user->name);
                                        }
                                    }
                                })
                                ->nullable(),

                            Forms\Components\TextInput::make('author_name')
                                ->label('Author Alias')
                                ->required()
                                ->maxLength(255)
                                ->helperText('Displayed name if different from user.'),

                            SpatieMediaLibraryFileUpload::make('featured_image')
                                ->collection('featured')
                                ->image()
                                ->imageEditor()
                                ->columnSpanFull(),
                        ])->grow(false), // Sidebar width fixed/smaller
                ])->from('md')->columnSpanFull(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                SpatieMediaLibraryImageColumn::make('featured_image')
                    ->collection('featured')
                    ->label('Image')
                    ->circular()
                    ->defaultImageUrl(fn () => 'https://ui-avatars.com/api/?name=Article&background=random'),

                Tables\Columns\TextColumn::make('title')
                    ->searchable()
                    ->sortable()
                    ->limit(40)
                    ->wrap(),

                Tables\Columns\TextColumn::make('author_name')
                    ->label('Author')
                    ->searchable()
                    ->sortable()
                    ->toggleable(),

                Tables\Columns\TextColumn::make('category.name')
                    ->label('Category')
                    ->badge()
                    ->sortable()
                    ->searchable(),

                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'published' => 'success',
                        'draft' => 'warning',
                        'archived' => 'gray',
                        default => 'secondary',
                    }),

                Tables\Columns\TextColumn::make('views')
                    ->numeric()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('published_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->options([
                        'draft' => 'Draft',
                        'published' => 'Published',
                        'archived' => 'Archived',
                    ]),

                Tables\Filters\SelectFilter::make('category')
                    ->relationship('category', 'name'),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->headerActions([
                ExportAction::make()->exporter(ArticleExporter::class),
                ImportAction::make()->importer(ArticleImporter::class),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('created_at', 'desc');
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
            'index' => Pages\ListArticles::route('/'),
            'create' => Pages\CreateArticle::route('/create'),
            'view' => Pages\ViewArticle::route('/{record}'),
            'edit' => Pages\EditArticle::route('/{record}/edit'),
        ];
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Section::make('Article Information')->schema([
                    TextEntry::make('title'),
                    TextEntry::make('slug'),
                    TextEntry::make('author_name')->label('Author'),
                    TextEntry::make('category.name')->label('Category')->badge(),
                    TextEntry::make('status')->badge(),
                    TextEntry::make('views'),
                    TextEntry::make('published_at')->dateTime(),
                ])->columns(2),

                Section::make('Content')->schema([
                    TextEntry::make('content')
                        ->html()
                        ->columnSpanFull(),
                ]),

                Section::make('Featured Image')->schema([
                    SpatieMediaLibraryImageEntry::make('featured_image')
                        ->collection('featured')
                        ->columnSpanFull(),
                ])->collapsible(),
            ]);
    }
}