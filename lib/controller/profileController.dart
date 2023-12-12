import 'package:gimme/data/profile.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:gimme/constants.dart';

class ProfileController{
    Future<Profile> findProfile(String uid) async{
        try{
          var response = await get(Uri.http(url,'$endpoint/users/$uid'));

          if(response.statusCode != 200) throw Exception(response.reasonPhrase);

          return Profile.fromJson(json.decode(response.body)['data']);
        }catch(e){
            throw Future.error(e.toString());
        }
    }

    static Future<Response> updateProfile(Profile profile) async{
        try{
          var response = await put(Uri.http(url,'$endpoint/users/${profile.uid}'),

          headers: {"Content-Type": "application/json"},  
          
          body: profile.toJson());

          if(response.statusCode != 200) throw Exception(response.reasonPhrase);

          return response;
        }catch(e){
            throw Future.error(e.toString());
        }
    }
  
}