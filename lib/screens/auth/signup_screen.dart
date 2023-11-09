import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:flutter/services.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreennState();
}

class _SignUpScreennState extends State<SignUpScreen> {
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  String defaultImage = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameinput = TextEditingController();
  TextEditingController emailinput = TextEditingController();
  TextEditingController passwordinput = TextEditingController();
  TextEditingController confirmpasswordinput = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  

  _changeObsecure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  _changeObsecureConfirm() {
    setState(() {
      _isObscureConfirm = !_isObscureConfirm;
    });
  }


  Future<String> encodeImageToBase64() async {
    final ByteData data = await rootBundle.load('assets/images/avatar/fathur.jpg');
    final List<int> bytes = data.buffer.asUint8List();
    final String base64String = base64Encode(bytes);
    return base64String;
  }

  @override
  void initState() {
    super.initState();
    encodeImageToBase64().then((value) {
      setState(() {
        defaultImage = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset : false,
          body: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Center(
                      child: Text(
                        "Sign Up to Gimme",
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
                      controller: usernameinput,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEFEFEF),
                        labelText: "Username",
                        prefixIcon: const Icon(Icons.person, color: Color(0xFF707070)),
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
                      controller: emailinput,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEFEFEF),
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email, color: Color(0xFF707070)),
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
                      controller: passwordinput,
                      obscureText: _isObscure,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500
                      ),
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
                    sizedBoxDefault,
                    TextFormField(
                      controller: confirmpasswordinput,
                      obscureText: _isObscureConfirm,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEFEFEF),
                        labelText: "Confirm Password",
                        prefixIcon: const Icon(Icons.lock, color: Color(0xFF707070)),
                        suffixIcon: IconButton(
                          onPressed: _changeObsecureConfirm,
                          icon: Icon(
                            _isObscureConfirm ? Icons.visibility_off : Icons.visibility,
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
                    sizedBoxDefault,
                    TextFormField(
                      controller: dateinput,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101)
                        );
                        
                        if(pickedDate != null ){
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                            setState(() {
                              dateinput.text = formattedDate;
                            });
                        }
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEFEFEF),
                        labelText: "Date of Birth",
                        prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF707070)),
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
                  ]
                ),
                sizedBoxDefault,
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (usernameinput.text.isEmpty || emailinput.text.isEmpty || passwordinput.text.isEmpty || confirmpasswordinput.text.isEmpty || dateinput.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill all the fields"),
                              backgroundColor: Colors.red,
                            )
                          );
                        } else if (passwordinput.text != confirmpasswordinput.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password and Confirm Password doesn't match"),
                              backgroundColor: Colors.red,
                            )
                          );
                        } else {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailinput.text,
                            password: passwordinput.text
                          ).then((value) {
                            FirebaseFirestore.instance.collection("users").doc(value.user!.uid).set({
                              "username": usernameinput.text,
                              "email": emailinput.text,
                              "dateofbirth": dateinput.text,
                              "profilepicture": defaultImage,
                              "uid": value.user!.uid
                            }).then((value) {
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
                            "Sign Up",
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
                          "Already have an account?",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/auth/signin');
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