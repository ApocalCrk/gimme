<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExerciseType extends Model
{
    use HasFactory;
    protected $table = 'exercise_type';
    protected $primaryKey = 'id_excercise_type';
    protected $fillable = [
        'description',
        'image',
        'detail_image',
        'exercises',
        'workout_name',
        'category',
    ];
}
