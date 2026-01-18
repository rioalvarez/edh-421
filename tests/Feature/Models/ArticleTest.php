<?php

use App\Models\Article;
use App\Models\User;
use App\Models\Category;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Carbon\Carbon;

uses(RefreshDatabase::class);

beforeEach(function () {
    $this->user = User::factory()->create();
});

describe('Article Model', function () {

    describe('Slug Generation', function () {

        it('generates slug automatically from title on create', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'title' => 'My First Article',
                'author_name' => 'Test Author',
                'content' => 'This is the content',
                'status' => 'draft',
            ]);

            expect($article->slug)->toBe('my-first-article');
        });

        it('generates slug with special characters removed', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'title' => 'Article with Special Characters! @#$%',
                'author_name' => 'Test Author',
                'content' => 'This is the content',
                'status' => 'draft',
            ]);

            // Note: @ is converted to "at" by Str::slug
            expect($article->slug)->toBe('article-with-special-characters-at');
        });

        it('generates slug from Indonesian title', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'title' => 'Artikel Pertama Saya',
                'author_name' => 'Test Author',
                'content' => 'Ini adalah konten artikel',
                'status' => 'draft',
            ]);

            expect($article->slug)->toBe('artikel-pertama-saya');
        });

        it('does not overwrite existing slug on create', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'title' => 'My Article',
                'slug' => 'custom-slug',
                'author_name' => 'Test Author',
                'content' => 'Content here',
                'status' => 'draft',
            ]);

            expect($article->slug)->toBe('custom-slug');
        });

        it('generates slug on update when title changes and slug is empty', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'title' => 'Original Title',
                'author_name' => 'Test Author',
                'content' => 'Content here',
                'status' => 'draft',
            ]);

            $article->update([
                'title' => 'Updated Title',
                'slug' => '',
            ]);

            expect($article->fresh()->slug)->toBe('updated-title');
        });
    });

    describe('Published Status', function () {

        it('isPublished returns true when status is published and published_at is in past', function () {
            $article = new Article([
                'status' => 'published',
                'published_at' => Carbon::yesterday(),
            ]);

            expect($article->isPublished())->toBeTrue();
        });

        it('isPublished returns false when status is draft', function () {
            $article = new Article([
                'status' => 'draft',
                'published_at' => Carbon::yesterday(),
            ]);

            expect($article->isPublished())->toBeFalse();
        });

        it('isPublished returns false when published_at is null', function () {
            $article = new Article([
                'status' => 'published',
                'published_at' => null,
            ]);

            expect($article->isPublished())->toBeFalse();
        });

        it('isPublished returns false when published_at is in future', function () {
            $article = new Article([
                'status' => 'published',
                'published_at' => Carbon::tomorrow(),
            ]);

            expect($article->isPublished())->toBeFalse();
        });
    });

    describe('View Counter', function () {

        it('incrementViews increases view count by 1', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'title' => 'Test Article',
                'author_name' => 'Test Author',
                'content' => 'Content',
                'status' => 'published',
                'views' => 0,
            ]);

            $article->incrementViews();

            expect($article->fresh()->views)->toBe(1);
        });

        it('incrementViews works multiple times', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'title' => 'Test Article',
                'author_name' => 'Test Author',
                'content' => 'Content',
                'status' => 'published',
                'views' => 10,
            ]);

            $article->incrementViews();
            $article->incrementViews();
            $article->incrementViews();

            expect($article->fresh()->views)->toBe(13);
        });
    });

    describe('Scopes', function () {

        beforeEach(function () {
            // Create published article
            Article::create([
                'user_id' => $this->user->id,
                'title' => 'Published Article',
                'author_name' => 'Test Author',
                'content' => 'Content',
                'status' => 'published',
                'published_at' => Carbon::yesterday(),
            ]);

            // Create draft article
            Article::create([
                'user_id' => $this->user->id,
                'title' => 'Draft Article',
                'author_name' => 'Test Author',
                'content' => 'Content',
                'status' => 'draft',
            ]);

            // Create archived article
            Article::create([
                'user_id' => $this->user->id,
                'title' => 'Archived Article',
                'author_name' => 'Test Author',
                'content' => 'Content',
                'status' => 'archived',
            ]);

            // Create scheduled article (published but future date)
            Article::create([
                'user_id' => $this->user->id,
                'title' => 'Scheduled Article',
                'author_name' => 'Test Author',
                'content' => 'Content',
                'status' => 'published',
                'published_at' => Carbon::tomorrow(),
            ]);
        });

        it('published scope returns only published articles with past published_at', function () {
            $articles = Article::published()->get();

            expect($articles)->toHaveCount(1);
            expect($articles->first()->title)->toBe('Published Article');
        });

        it('draft scope returns only draft articles', function () {
            $articles = Article::draft()->get();

            expect($articles)->toHaveCount(1);
            expect($articles->first()->title)->toBe('Draft Article');
        });

        it('archived scope returns only archived articles', function () {
            $articles = Article::archived()->get();

            expect($articles)->toHaveCount(1);
            expect($articles->first()->title)->toBe('Archived Article');
        });
    });

    describe('Relationships', function () {

        it('belongs to author (user)', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'title' => 'Test Article',
                'author_name' => 'Test Author',
                'content' => 'Content',
                'status' => 'draft',
            ]);

            expect($article->author)->toBeInstanceOf(User::class);
            expect($article->author->id)->toBe($this->user->id);
        });

        it('belongs to category', function () {
            $category = Category::create(['name' => 'Technology', 'slug' => 'technology']);

            $article = Article::create([
                'user_id' => $this->user->id,
                'category_id' => $category->id,
                'title' => 'Test Article',
                'author_name' => 'Test Author',
                'content' => 'Content',
                'status' => 'draft',
            ]);

            expect($article->category)->toBeInstanceOf(Category::class);
            expect($article->category->id)->toBe($category->id);
        });

        it('can have null category', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'category_id' => null,
                'title' => 'Test Article',
                'author_name' => 'Test Author',
                'content' => 'Content',
                'status' => 'draft',
            ]);

            expect($article->category)->toBeNull();
        });
    });

    describe('Date Casting', function () {

        it('casts published_at to Carbon instance', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'title' => 'Test Article',
                'author_name' => 'Test Author',
                'content' => 'Content',
                'status' => 'published',
                'published_at' => '2024-06-15 10:30:00',
            ]);

            expect($article->published_at)->toBeInstanceOf(Carbon::class);
        });
    });

    describe('Views Casting', function () {

        it('casts views to integer', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'title' => 'Test Article',
                'author_name' => 'Test Author',
                'content' => 'Content',
                'status' => 'draft',
                'views' => '100',
            ]);

            expect($article->views)->toBeInt();
            expect($article->views)->toBe(100);
        });
    });

    describe('Fillable Attributes', function () {

        it('allows mass assignment of fillable attributes', function () {
            $article = Article::create([
                'user_id' => $this->user->id,
                'title' => 'Test Title',
                'slug' => 'test-slug',
                'author_name' => 'John Doe',
                'content' => 'Test content',
                'status' => 'published',
                'published_at' => Carbon::now(),
                'views' => 50,
            ]);

            expect($article->title)->toBe('Test Title');
            expect($article->slug)->toBe('test-slug');
            expect($article->author_name)->toBe('John Doe');
            expect($article->content)->toBe('Test content');
            expect($article->status)->toBe('published');
            expect($article->views)->toBe(50);
        });
    });
});
