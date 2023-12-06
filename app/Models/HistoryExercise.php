<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HistoryExercise extends Model
{
    use HasFactory;
    protected $table = 'history_exercise';
    protected $primaryKey = 'id_history_exercise';
    protected $fillable = [
        'uid',
        'id_exercise_type',
        'duration',
        'calories',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'uid', 'uid');
    }

    public function ExerciseType(){
        return $this->belongsTo(ExerciseType::class, 'id_exercise_type', 'id_exercise_type');
    }
}