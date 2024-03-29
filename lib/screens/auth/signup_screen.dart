// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/auth/controller/register.dart';
import 'package:gimme/screens/auth/model/User.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreennState();
}

class _SignUpScreennState extends State<SignUpScreen> {
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  String defaultImage = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameInput = TextEditingController();
  TextEditingController usernameInput = TextEditingController();
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


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset : true,
          body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  primary2Color.withAlpha(50),
                  lowPrimaryColor.withAlpha(70),
                  primary2Color.withAlpha(50),
                ]
              )
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Let's Sign you up.",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Please fill in this form to create an account.",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: secondaryColor
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            key: Key('name'),
                            controller: nameInput,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: secondaryColor,
                                ),
                              ),
                              labelText: "Name",
                              labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: secondaryColor
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            key: Key('email'),
                            controller: emailinput,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: secondaryColor,
                                ),
                              ),
                              labelText: "Email",
                              labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: secondaryColor
                              ),
                            ),
                            validator: (value) {
                              if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value!)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            key: Key('username'),
                            controller: usernameInput,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: secondaryColor,
                                ),
                              ),
                              labelText: "Username",
                              labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: secondaryColor
                              ),
                            )
                          ),
                          sizedBoxDefault,
                          TextFormField(
                            key: Key('password'),
                            controller: passwordinput,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: secondaryColor,
                                ),
                              ),
                              labelText: "Password",
                              labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: secondaryColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _changeObsecure();
                                  });
                                },
                                color: secondaryColor,
                                icon: _isObscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          sizedBoxDefault,
                          TextFormField(
                            key: Key('confirm_password'),
                            controller: confirmpasswordinput,
                            obscureText: _isObscureConfirm,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: secondaryColor,
                                ),
                              ),
                              labelText: "Confirm Password",
                              labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: secondaryColor
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _changeObsecureConfirm();
                                  });
                                },
                                color: secondaryColor,
                                icon: _isObscureConfirm ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent
                              )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          sizedBoxDefault,
                          TextFormField(
                            key: Key('date'),
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
                              labelText: "Date of Birth",
                              labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: secondaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your date of birth';
                              }
                              return null;
                            },
                          ),
                        ]
                      ),
                    ),
                    sizedBoxDefault,
                    sizedBoxDefault,
                    Column(
                      children: [
                        ElevatedButton(
                          key: const Key('signUpButton'),
                          onPressed: () {
                            if (nameInput.text.isEmpty || emailinput.text.isEmpty || passwordinput.text.isEmpty || confirmpasswordinput.text.isEmpty || dateinput.text.isEmpty) {
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
                              if (_formKey.currentState!.validate()) {
                                User user = User(
                                  name: nameInput.text,
                                  email: emailinput.text,
                                  username: usernameInput.text,
                                  password: passwordinput.text,
                                  dateofbirth: dateinput.text,
                                  photoUrl: 'avatar/fathur.jpg',
                                  phoneNumber: '-',
                                  address: '-',
                                  height: '-',
                                  weight: '-'
                                );
                                RegisterCredential().credentialRegister(
                                  user,
                                  context
                                );
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
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
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20
                                )
                              ),
                            ),
                          ),
                        ),
                        sizedBoxDefault,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(Colors.transparent)
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/auth/signin');
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}