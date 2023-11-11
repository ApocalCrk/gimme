import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';


class RegisterCredential {
  credentialRegister(String email, String password, String username, String dateinput, String defaultImage, BuildContext context) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    ).then((value) {
      FirebaseFirestore.instance.collection("users").doc(value.user!.uid).set({
        "username": username, 
        "email": email,
        "dateofbirth": dateinput,
        "profilepicture": defaultImage,
        "uid": value.user!.uid
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Congrats, your account has been created!"),
            backgroundColor: successColor
          )
        );
        Navigator.pushNamed(context, '/auth/signin');
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        )
      );
    });
  }
}