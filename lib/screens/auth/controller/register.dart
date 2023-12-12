import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/auth/model/User.dart';
import 'package:gimme/screens/auth/signin_screen.dart';
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
        // Navigator.pushNamed(context, '/auth/signin');
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
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