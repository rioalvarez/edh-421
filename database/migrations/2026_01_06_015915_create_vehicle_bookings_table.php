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
        Schema::create('vehicle_bookings', function (Blueprint $table) {
            $table->id();
            $table->string('booking_number')->unique(); // Nomor peminjaman auto-generate
            $table->foreignId('user_id')->constrained()->cascadeOnDelete(); // Pemohon
            $table->foreignId('vehicle_id')->constrained()->cascadeOnDelete(); // Kendaraan

            // Data pengemudi
            $table->string('driver_name'); // Nama pengemudi (bisa pegawai/non-pegawai)
            $table->string('driver_phone')->nullable(); // Nomor telepon pengemudi

            // Data surat tugas
            $table->string('document_number'); // Nomor surat tugas
            $table->json('passengers')->nullable(); // Daftar pegawai yang ikut serta

            // Data perjalanan
            $table->string('destination'); // Alamat tujuan dinas
            $table->text('purpose'); // Keperluan/tujuan dinas
            $table->date('start_date'); // Tanggal mulai
            $table->date('end_date'); // Tanggal selesai
            $table->time('departure_time')->nullable(); // Jam keberangkatan

            // Status peminjaman: approved (auto), in_use, completed, cancelled
            $table->enum('status', ['approved', 'in_use', 'completed', 'cancelled'])->default('approved');

            // Data pengembalian (diisi saat pengembalian)
            $table->unsignedInteger('start_odometer')->nullable(); // KM awal
            $table->unsignedInteger('end_odometer')->nullable(); // KM akhir
            $table->enum('fuel_level', ['empty', 'quarter', 'half', 'three_quarter', 'full'])->nullable(); // Level BBM saat dikembalikan
            $table->text('return_condition')->nullable(); // Kondisi kendaraan saat dikembalikan
            $table->text('return_notes')->nullable(); // Catatan pengembalian
            $table->timestamp('returned_at')->nullable(); // Waktu pengembalian

            $table->text('notes')->nullable(); // Catatan tambahan
            $table->text('cancellation_reason')->nullable(); // Alasan pembatalan
            $table->timestamps();

            // Index untuk query availability
            $table->index(['vehicle_id', 'start_date', 'end_date', 'status']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('vehicle_bookings');
    }
};
