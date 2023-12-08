<?php

namespace App\Http\Controllers;

use App\Models\Membership;
use App\Models\QrTimeout;
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
        $membership = Membership::where('id_gym', $id_gym)->where('uid', $uid)->where('end_date', '>', now())->first();
        if($membership){
            return response()->json(['status' => 'success', 'data' => $membership], 200);
        }else{
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function getAllMembership($uid){
        $membership = Membership::with('gym')->where('uid', $uid)->where('end_date', '>=', now())->get();
        if($membership){
            $membership->map(function($item){
                $qrCheck = QrTimeout::where('id_membership', $item->id)->first();
                if($qrCheck){
                    if(now() > $qrCheck->timeout){
                        $qrCheck->delete();
                        $item->qrCheck = false;
                    }else{
                        $item->qrCheck = true;
                        $item->qrCheckId = $qrCheck->id_qr;
                        $item->qrCheckTime = $qrCheck->timeout;
                    }
                }else{
                    $item->qrCheck = false;
                }
                $item->gym->image = asset('storage/'.$item->gym->image);
                return $item;
            });
            return response()->json(['status' => 'success', 'data' => $membership], 200);
        }else{
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function generateQrCode(Request $request){
        try{
            $id_membership = $request->id_membership;
            $qrData = QrTimeout::create([
                'id_qr' => rand(100000, 999999),
                'id_membership' => $id_membership,  
                'timeout' => now()->addHours(12)
            ]);
            return response()->json(['status' => 'success', 'data' => $qrData], 200);
        }catch(\Exception $e){
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function checkoutMembership(Request $request){
        try{
            $id_qr = $request->id_qr;
            $qrData = QrTimeout::where('id_qr', $id_qr)->first();
            if($qrData){
                $qrData->delete();
                return response()->json(['status' => 'success'], 200);
            }else{
                return response()->json(['status' => 'fail'], 401);
            }
        }catch(\Exception $e){
            return response()->json(['status' => 'fail'], 401);
        }
    }
}
