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

    public function gym(){
        return $this->belongsTo(Gym::class, 'id_gym', 'id_gym');
    }

    public function transaction(){
        return $this->belongsTo(Transaction::class, 'id_transaction', 'id_transaction');
    }

    public function user(){
        return $this->belongsTo(User::class, 'uid', 'uid');
    }
}
