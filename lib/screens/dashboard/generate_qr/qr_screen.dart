import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:gimme/constants.dart';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({Key? key}) : super(key: key);

  @override
  _QrGeneratorScreenState createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  String qrCode = "0xFF${Random().nextInt(999999)}";

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        data: qrCode,
                        version: QrVersions.auto,
                        size: MediaQuery.of(context).size.width * 0.8,
                      ),
                      Text(qrCode, style: const TextStyle(fontFamily: "Montserrat", fontSize: 20, fontWeight: FontWeight.bold)),
                    ]
                  )
                ),
                sizedBoxDefault,
                Container(
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
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}