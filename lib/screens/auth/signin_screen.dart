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
  final TextEditingController _usernameController = TextEditingController();
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
                  primary2Color.withAlpha(50),
                  lowPrimaryColor.withAlpha(70),
                  primary2Color.withAlpha(50),
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
                            color: secondaryColor
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "You've been missed!",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: secondaryColor
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          key: const ValueKey("username"),
                          controller: _usernameController,
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
                          key: const ValueKey("password"),
                          controller: _passwordController,
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
                                _changeObsecure();
                              },
                              color: secondaryColor,
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
                        key: const ValueKey("login"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            CredentialLogin().verifiedCredential(_usernameController.text, _passwordController.text, context);
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile/privacy_policy');
                        },
                        child: const Text(
                          'By continuing, you acknowledge that you have read, and understood and agree to our Privacy policy.',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: secondaryColor
                          ),
                          textAlign: TextAlign.center,
                        ),
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