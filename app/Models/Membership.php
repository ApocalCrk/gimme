<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Membership extends Model
{
    use HasFactory;
    protected $table = 'membership';
    protected $fillable = [
        'uid',
        'id_gym',
        'id_transaction',
        'start_date',
        'end_date'
    ];
}
