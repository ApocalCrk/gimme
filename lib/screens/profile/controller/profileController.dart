import 'dart:io';

import 'package:gimme/screens/auth/model/User.dart';
import 'package:gimme/screens/profile/model/profile.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:gimme/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController {
  // Future<Profile> findProfile(int uid) async {
  //   try {
  //     var response = await get(Uri.http(url, '$endpoint/user/$uid'));

  //     if (response.statusCode != 200) throw Exception(response.reasonPhrase);
  //     print(json.decode(response.body)['data']);
  //     return Profile.fromJson(json.decode(response.body)['data']);
  //   } catch (e) {
  //     throw Future.error(e.toString());
  //   }
  // }

  Future<User> findById(int id) async {
    try {
      var response =
          await get(Uri.http(url, '$endpoint/user/findDatabyId/$id'));

      if (response.statusCode != 200) {
        throw Exception(
            'Request failed with status: ${response.statusCode}. Reason: ${response.reasonPhrase}');
      }

      var jsonData = jsonDecode(response.body)['data'];
      User data = User(
        email: jsonData['email'],
        name: jsonData['name'],
        username: jsonData['username'],
        password: jsonData['password'],
        photoUrl: jsonData['profilepicture'],
        dateofbirth: jsonData['dateofbirth'],
        phoneNumber: jsonData['phone_number'],
        address: jsonData['address'],
        height: jsonData['height'],
        weight: jsonData['weight'],
      );
      return data;
    } catch (e) {
      throw Exception('Error in findById: $e');
    }
  }

  // static Future<Response> updateProfile(Profile profile) async {
  //   try {
  //     var response = await put(Uri.http(url, '$endpoint/users/${profile.uid}'),
  //         headers: {"Content-Type": "application/json"},
  //         body: profile.toJson());

  //     if (response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     return response;
  //   } catch (e) {
  //     throw Future.error(e.toString());
  //   }
  // }

  // static Future<Response> updateProfilePhoto(String id, File image) async {
  //   try {
  //     var request = MultipartRequest(
  //       'POST',
  //       Uri.http(url, '$endpoint/user/updatePhoto/${id}'),
  //     );
  //     request.files.add(
  //       await MultipartFile.fromPath(
  //         'photo',
  //         image.path,
  //       ),
  //     );
  //     var response = await request.send();
  //     return await Response.fromStream(response);
  //   } catch (e) {
  //     throw Future.error(e.toString());
  //   }
  // }

  static Future<void> updatePhoto(int uid, File image) async {
    try {
      var request = MultipartRequest(
          'POST', Uri.http(url, '$endpoint/user/updatePhoto/$uid'));
      request.headers.addAll({'Content-Type': 'multipart/form-data'});
      request.fields["_method"] = "PUT";
      request.files
          .add(await MultipartFile.fromPath('profilepicture', image.path));

      var response = await request.send();
      var responBody = await Response.fromStream(response);
      if (response.statusCode == 200) {
        print("response body success :${responBody.body}");
      } else {
        print(response.statusCode);
        print(responBody.body.toString());
        print("response body salah :${responBody.body}");
      }
    } catch (e) {
      print("response body error : $e");
    }
  }
}
