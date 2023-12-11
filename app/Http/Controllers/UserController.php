<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    public function login(Request $request){
        $username = $request->input('username');
        $password = $request->input('password');
        $user = User::where('username', $username)->first();
        if($user){
            if(Hash::check($password, $user->password)){
                $user->profilepicture = asset('storage/'.$user->profilepicture);
                return response()->json(['status' => 'success', 'data' => $user],200);
            }else{
                return response()->json(['status' => 'fail'],401);
            }
        }else{
            return response()->json(['status' => 'fail'],401);
        }
    }

    public function register(Request $request){
        $username = $request->input('username');
        $user = User::where('username', $username)->first();
        if($user){
            return response()->json(['status' => 'fail'],401);
        }else{
            $user = new User();
            $user->name = $request->input('name');
            $user->email = $request->input('email');
            $user->username = $request->input('username');
            $user->password = Hash::make($request->input('password'));
            $user->profilepicture = $request->input('profilepicture');
            $user->dateofbirth = $request->input('dateofbirth');
            $user->phone_number = $request->input('phone_number');
            $user->address = $request->input('address');
            $user->height = $request->input('height');
            $user->weight = $request->input('weight');
            $user->save();
            return response()->json(['status' => 'success'],200);
        }
    }

    public function updateUser(Request $request){
        $username = $request->input('username');
        $user = User::where('username', $username)->first();
        if($user){
            $user->name = $request->input('name');
            $user->email = $request->input('email');
            $user->dateofbirth = $request->input('dateofbirth');
            $user->phone_number = $request->input('phone_number');
            $user->address = $request->input('address');
            $user->height = $request->input('height');
            $user->weight = $request->input('weight');
            $user->save();
            return response()->json(['status' => 'success'],200);
        }else{
            return response()->json(['status' => 'fail'],401);
        }
    }
    
    public function findDatabyId($id){
        $user = User::find($id)->first();
        if($user){
            $user->profilepicture = asset('storage/'.$user->profilepicture);
            return response()->json(['message' => 'got user', 'data' => $user]);
        }else{
            return response()->json(['message' => 'fail', 'data' => $user]);
        }
    }

    public function updatePhoto(Request $request, $id)
    {
        $user = User::find($id)->first();
        $previousPhotoPath = $user->profilepicture;
        if ($request->hasFile('profilepicture')) {
            $photo = $request->file('profilepicture');
            $originalName = $photo->getClientOriginalName();
            $photoPath = $photo->storeAs('public/avatar', $originalName);
            $photoPath = 'avatar/'.$originalName;

            if ($previousPhotoPath && Storage::exists('public/'.$previousPhotoPath)) {
                Storage::delete('public/'.$previousPhotoPath);
            }
            $user->profilepicture = $photoPath;
            print_r($user->profilepicture);
            $user->save();
            return response()->json(['message' => 'Profile photo updated successfully', 'data' => $user->profilepicture]);
        }else{
            print_r($user->profilepicture);
            return response()->json(['message' => 'Kontol', 'data' => $user->profilepicture]);
        }
    }


}
