import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/auth/controller/register.dart';
import 'package:intl/intl.dart';
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
          body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  primary2Color.withAlpha(100),
                  lowPrimaryColor.withAlpha(80),
                  primary2Color.withAlpha(100),
                ]
              )
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                            color: Colors.grey
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: usernameinput,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            labelText: "Username",
                            labelStyle: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailinput,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            labelText: "Email",
                            labelStyle: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey
                            ),
                          )
                        ),
                        sizedBoxDefault,
                        TextFormField(
                          controller: passwordinput,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            labelText: "Password",
                            labelStyle: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _changeObsecure();
                                });
                              },
                              color: Colors.grey,
                              icon: _isObscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent
                            ),
                          )
                        ),
                        sizedBoxDefault,
                        TextFormField(
                          controller: confirmpasswordinput,
                          obscureText: _isObscureConfirm,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            labelText: "Confirm Password",
                            labelStyle: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _changeObsecureConfirm();
                                });
                              },
                              color: Colors.grey,
                              icon: _isObscureConfirm ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent
                            )
                          )
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
                            labelText: "Date of Birth",
                            labelStyle: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ]
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
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
                              RegisterCredential().credentialRegister(emailinput.text, passwordinput.text, usernameinput.text, dateinput.text, defaultImage, context);
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
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Or Register With",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                        sizedBoxDefault,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.2),
                                  width: 1
                                ),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
                                child: IconButton(
                                onPressed: () {},
                                icon: Image.asset("assets/images/icon/google.png", width: 100, height: 100),
                              ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff1877F2),
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.2),
                                  width: 1
                                ),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
                                child: IconButton(
                                onPressed: () {},
                                icon: Image.asset("assets/images/icon/facebook.png", width: 100, height: 100),
                              ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.2),
                                  width: 2
                                ),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
                                child: IconButton(
                                onPressed: () {},
                                icon: Image.asset("assets/images/icon/x.png", width: 100, height: 100),
                              ),
                              ),
                            ),
                          ],
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
          )
        ),
      ),
    );
  }
}