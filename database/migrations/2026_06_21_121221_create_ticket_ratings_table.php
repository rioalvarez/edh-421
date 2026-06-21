<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('ticket_ratings', function (Blueprint $table) {
            $table->id();
            $table->foreignId('ticket_id')->unique()->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->tinyInteger('score'); // 1-5
            $table->text('feedback')->nullable();
            $table->timestamps();

            $table->index(['user_id', 'created_at']);
            $table->index('score');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ticket_ratings');
    }
};
