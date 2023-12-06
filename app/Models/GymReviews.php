<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GymReviews extends Model
{
    use HasFactory;
    protected $table = 'gym_reviews';
    protected $primaryKey = 'id_review';
    protected $fillable = [
        'id_gym',
        'uid',
        'rating',
        'description'
    ];

    public function gym()
    {
        return $this->belongsTo(Gym::class, 'id_gym', 'id_gym');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'uid', 'uid');
    }
}
