import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gson/gson.dart';

class CredentialLogin {
  verifiedCredential(String email, String password, BuildContext context) {
    FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password
    ).then((value) {
    FirebaseFirestore.instance.collection('users').doc(value.user!.uid).get().then((value) {
      SharedPref.saveStr('username', value.data()!['username']);
      SharedPref.saveStr('email', value.data()!['email']);
      SharedPref.saveStr('uid', value.data()!['uid']);
      SharedPref.saveStr('photoURL', value.data()!['profilepicture']);
      SharedPref.saveStr('dateofbirth', value.data()!['dateofbirth']);
      SharedPref.saveStr("shortcuts", gson.encode(defaultShortcut));
      dataUser = {
        'username': value.data()!['username'],
        'email': value.data()!['email'],
        'uid': value.data()!['uid'],
        'photoURL': value.data()!['profilepicture'],
        'dateofbirth': value.data()!['dateofbirth'],
        'shortcuts': defaultShortcut
      };
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Welcome back, ${value.data()!['username']}"),
          backgroundColor: Colors.green,
        )
      );
      Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
    });
    }).catchError((e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      )
    );
    });
  }
}