<?php

namespace Database\Seeders;

use App\Models\Article;
use Illuminate\Database\Seeder;

class ArticleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Generate 10 articles with mixed statuses
        Article::factory(5)->published()->create();
        Article::factory(3)->draft()->create();
        Article::factory(2)->archived()->create();
    }
}
