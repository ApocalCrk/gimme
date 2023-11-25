import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gson/gson.dart';
import 'package:http/http.dart';

class CredentialLogin {
  verifiedCredential(String username, String password, BuildContext context){
    var response = post(Uri.http(url, '$endpoint/auth/login'), body: {
      'username': username,
      'password': password
    });
    response.then((value) {
      if(value.statusCode == 200){
        var user = jsonDecode(value.body)['data'];
        SharedPref.saveStr('name', user['name']);
        SharedPref.saveStr('username', user['username']);
        SharedPref.saveStr('email', user['email']);
        SharedPref.saveStr('uid', user['uid'].toString());
        SharedPref.saveStr('photoURL', user['profilepicture']);
        SharedPref.saveStr('dateofbirth', user['dateofbirth']);
        SharedPref.saveStr("shortcuts", gson.encode(defaultShortcut));
        dataUser = {
          'name': user['name'],
          'email': user['email'],
          'username': user['username'],
          'uid': user['uid'],
          'photoURL': user['profilepicture'],
          'dateofbirth': user['dateofbirth'],
          'shortcuts': defaultShortcut
        };
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Welcome back, ${user['name']}"),
            backgroundColor: Colors.green,
          )
        );
        Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email or password is wrong"),
            backgroundColor: Colors.red,
          )
        );
      }
    });
  }   
}