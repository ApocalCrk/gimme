<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Gym extends Model
{
    use HasFactory;
    protected $table = 'gym';
    protected $primaryKey = 'id_gym';
    protected $fillable = [
        'name',
        'facilities',
        'description',
        'location',
        'image',
        'place',
        'packages'
    ];
}
