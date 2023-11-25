<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::prefix('v1')->group(function() {
    Route::prefix('auth')->group(function(){
        Route::post('login', 'App\Http\Controllers\UserController@login');
        Route::post('register', 'App\Http\Controllers\UserController@register');
    });
    Route::prefix('gym')->group(function(){
        Route::get('getMapsDetailGym/{lat}/{long}', 'App\Http\Controllers\GymController@getMapsDetailGym');
        Route::get('getDetailGymId/{id}', 'App\Http\Controllers\GymController@getDetailGymId');
    });
});