<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class QrTimeout extends Model
{
    use HasFactory;
    protected $table = 'qr_timeout';
    protected $primaryKey = 'id_qr';
    protected $fillable = [
        'id_qr',
        'id_membership',
        'timeout'
    ];

    public function membership(){
        return $this->belongsTo(Membership::class, 'id_membership', 'id');
    }
}
