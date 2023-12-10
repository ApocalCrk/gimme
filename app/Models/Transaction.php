<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    use HasFactory;
    protected $primaryKey = 'id_transaction';
    protected $fillable = [
        'id_transaction',
        'uid',
        'id_gym',
        'payment_method',
        'payment_status',
        'payment_amount',
        'bundle',
        'type_membership'
    ];

    public function user(){
        return $this->belongsTo(User::class, 'uid', 'uid');
    }

    public function gym(){
        return $this->belongsTo(Gym::class, 'id_gym', 'id_gym');
    }

    public function membership(){
        return $this->hasOne(Membership::class, 'id_transaction', 'id_transaction');
    }
}
