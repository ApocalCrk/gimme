<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    use HasFactory;
    protected $primaryKey = 'id_transaction';
    protected $fillable = [
        'uid',
        'id_gym',
        'payment_method',
        'payment_status',
        'payment_amount',
        'bundle',
        'type_membership'
    ];
}
