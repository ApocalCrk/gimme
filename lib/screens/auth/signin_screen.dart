import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _changeObsecure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Center(
                      child: Text(
                        "Sign In to Gimme",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEFEFEF),
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.mail, color: Color(0xFF707070)),
                        labelStyle: const TextStyle(
                          color: secondaryColor,
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFEFEFEF),
                            width: 1
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFEFEFEF),
                            width: 1
                          )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                            width: 1
                          )
                        )
                      ),
                    ),
                    sizedBoxDefault,
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEFEFEF),
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock, color: Color(0xFF707070)),
                        suffixIcon: IconButton(
                          onPressed: _changeObsecure,
                          icon: Icon(
                            _isObscure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.black.withOpacity(0.5)
                          ),
                        ),
                        labelStyle: const TextStyle(
                          color: secondaryColor,
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFEFEFEF),
                            width: 1
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFEFEFEF),
                            width: 1
                          )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                            width: 1
                          )
                        )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/auth/forgot');
                          },
                        )
                      ],
                    ),
                  ]
                ),
                sizedBoxDefault,
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text
                          ).then((value) {
                            FirebaseFirestore.instance.collection('users').doc(value.user!.uid).get().then((value) {
                              SharedPref.saveStr('username', value.data()!['username']);
                              SharedPref.saveStr('email', value.data()!['email']);
                              SharedPref.saveStr('uid', value.data()!['uid']);
                              SharedPref.saveStr('photoURL', value.data()!['profilepicture']);
                              SharedPref.saveStr('dateofbirth', value.data()!['dateofbirth']);
                              dataUser = {
                                'username': value.data()!['username'],
                                'email': value.data()!['email'],
                                'uid': value.data()!['uid'],
                                'photoURL': value.data()!['profilepicture'],
                                'dateofbirth': value.data()!['dateofbirth']
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
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => primaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        )
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                            )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/auth/signup');
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}