<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('theme_sidebar_style')->default('default')->after('theme_gray_level');
            $table->string('theme_navbar_style')->default('clean')->after('theme_sidebar_style');
            $table->string('theme_density')->default('comfortable')->after('theme_navbar_style');
            $table->string('theme_radius')->default('default')->after('theme_density');
            $table->string('theme_content_width')->default('normal')->after('theme_radius');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn([
                'theme_sidebar_style',
                'theme_navbar_style',
                'theme_density',
                'theme_radius',
                'theme_content_width',
            ]);
        });
    }
};
