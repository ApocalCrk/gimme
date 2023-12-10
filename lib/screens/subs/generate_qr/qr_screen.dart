import 'package:flutter/material.dart';
import 'package:gimme/controller/generatorController.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:gimme/constants.dart';

class QrGeneratorScreen extends StatefulWidget {
  final int id;
  const QrGeneratorScreen({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QrGeneratorScreenState createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [primaryColor, primary2Color], begin: Alignment.topCenter, end: Alignment.bottomCenter)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                sizedBoxDefault,
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    children: [
                      QrImageView(
                        data: widget.id.toString(),
                        version: QrVersions.auto,
                        size: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ]
                  )
                ),
                sizedBoxDefault,
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        GeneratorController().checkoutMembership(widget.id).then((value) {
                          if (value == 'success') {
                            Navigator.popAndPushNamed(context, '/subs');
                          }
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: errorColor,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Center(
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                              fontFamily: "Montserrat", 
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ),
                      ),
                    ),
                    sizedBoxDefault,
                    GestureDetector(
                      onTap: () => Navigator.popAndPushNamed(context, '/subs'),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: lowSecondaryColor,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Center(
                          child: Text(
                            "Back",
                            style: TextStyle(
                              fontFamily: "Montserrat", 
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}