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
            $getTransaction = Transaction::with('gym', 'membership')->where('id_transaction', $transaction->id_transaction)->first();
            return response()->json(['status' => 'success', 'data' => $getTransaction], 200);
        }catch(\Exception $e){
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function findMembershipCheck($id_gym, $uid){
        $membership = Membership::where('id_gym', $id_gym)->where('uid', $uid)->first();
        if($membership){
            return response()->json(['status' => 'success', 'data' => $membership], 200);
        }else{
            return response()->json(['status' => 'fail'], 401);
        }
    }
}
