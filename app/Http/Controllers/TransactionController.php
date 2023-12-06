<?php

namespace App\Http\Controllers;

use App\Models\Membership;
use Illuminate\Http\Request;
use App\Models\Transaction;

class TransactionController extends Controller
{
    public function sendTransaction(Request $request){
        try{
            $data = $request->all();
            Transaction::create($data);
            $transaction = Transaction::where('id_gym', $request->id_gym)->where('uid', $request->uid)->where('type_membership', $request->type_membership)->first();
            Membership::create([
                'uid' => $request->uid,
                'id_gym' => $request->id_gym,
                'id_transaction' => $transaction->id_transaction,
                'start_date' => now(),
                'end_date' => explode(' ', $request->type_membership)[1] == "Month" ? now()->addMonth() : now()->addYear()
            ]);
            return response()->json(['status' => 'success'], 200);
        }catch(\Exception $e){
            return response()->json(['status' => 'fail'], 401);
        }
    }
}
