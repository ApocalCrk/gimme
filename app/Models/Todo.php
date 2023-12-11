<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Todo extends Model
{
    use HasFactory;

    protected $table = 'todo';

    protected $fillable = [
        'uid',
        'title',
        'calories',
        'duration',
        'date'
    ];

    public function user() {
        return $this->belongsTo(User::class, 'uid', 'uid');
    }
}
