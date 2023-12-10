import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/auth/controller/login.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          resizeToAvoidBottomInset: false,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Let's Sign you in.",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Welcome back",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "You've been missed!",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _emailController,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
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
                                _changeObsecure();
                              },
                              color: Colors.grey,
                              icon: _isObscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        sizedBoxDefault,
                        sizedBoxDefault,
                        sizedBoxDefault
                      ]
                    ),
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            CredentialLogin().verifiedCredential(_emailController.text, _passwordController.text, context);
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
                              "Sign In",
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
                              "Or Login With",
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
                              icon: Image.asset("assets/images/icon/google.png", width: 30, height: 30, fit: BoxFit.fill),
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
                              icon: Image.asset("assets/images/icon/facebook.png", width: 30, height: 30, fit: BoxFit.fill),
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
                              icon: Image.asset("assets/images/icon/x.png", width: 30, height: 30, fit: BoxFit.fill),
                            ),
                            ),
                          ),
                        ],
                      ),
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
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/auth/signup');
                            },
                            child: const Text(
                              "Sign Up",
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
                      sizedBoxDefault,
                      const Text(
                        'By continuing, you acknowledge that you have read, and understood and agree to our Privacy policy.',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: secondaryColor
                        )
                      )    
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}