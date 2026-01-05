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
        Schema::create('tickets', function (Blueprint $table) {
            $table->id();
            $table->string('ticket_number')->unique();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete(); // Pelapor
            $table->foreignId('device_id')->nullable()->constrained()->nullOnDelete(); // Perangkat terkait
            $table->foreignId('assigned_to')->nullable()->constrained('users')->nullOnDelete(); // IT Admin yang handle
            $table->enum('category', ['hardware', 'software', 'network', 'printer', 'other'])->default('hardware');
            $table->enum('priority', ['low', 'medium', 'high', 'critical'])->default('medium');
            $table->string('subject');
            $table->text('description');
            $table->enum('status', ['open', 'in_progress', 'waiting_for_user', 'resolved', 'closed'])->default('open');
            $table->text('resolution_notes')->nullable();
            $table->timestamp('resolved_at')->nullable();
            $table->timestamp('closed_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tickets');
    }
};
