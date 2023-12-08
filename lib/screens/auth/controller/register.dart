import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/auth/model/User.dart';
import 'package:http/http.dart';


class RegisterCredential {
  credentialRegister(User user, BuildContext context){
    var response = post(Uri.http(url, '$endpoint/auth/register'), body: user.toJson());
    response.then((value) {
      if(value.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Congrats, your account has been created!"),
            backgroundColor: successColor
          )
        );
        Navigator.pushNamed(context, '/auth/signin');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value.body),
            backgroundColor: Colors.red,
          )
        );
      }
    });
    
  }
}