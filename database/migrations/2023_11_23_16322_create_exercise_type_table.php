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
        Schema::create('exercise_type', function (Blueprint $table) {
            $table->id('id_exercise_type');
            $table->text('description');
            $table->string('image');
            $table->longText('exercises');
            $table->string('name');
            $table->text('category');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('exercise_type');
    }
};
