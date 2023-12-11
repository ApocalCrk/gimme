<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\ExerciseType;

class HistoryExercise extends Model
{
    use HasFactory;

    protected $table = 'history_exercise';

    protected $primaryKey = 'id_history_exercise';

    protected $fillable = [
        'uid',
        'id_exercise_type',
        'duration',
        'calories'
    ];

    public function exerciseType() {
        return $this->belongsTo(ExerciseType::class, 'id_exercise_type', 'id_exercise_type');
    }
}
