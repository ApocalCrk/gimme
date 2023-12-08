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
        Schema::create('history_exercise', function (Blueprint $table) {
            $table->id('id_history_exercise');
            $table->foreignId('uid')->references('uid')->on('users');
            $table->foreignId('id_exercise_type')->references('id_exercise_type')->on('exercise_type');
            $table->integer('duration');
            $table->integer('calories');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('history_exercise');
    }
};
