// ignore_for_file: must_be_immutable, non_constant_identifier_names
import 'package:gimme/constants.dart';
import 'package:http/http.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';

class Scanner extends StatelessWidget {
  final BuildContext context;
  Scanner({super.key, required this.context});

  _checkGymOnDatabase(id_gym) async {
    await get(Uri.http(url, "$endpoint/gym/getDetailGymId/$id_gym")).then((value) {
      if (value.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/gym/detail', arguments: {
          'id': int.parse(id_gym.toString()),
          'route': '/dashboard'
        });
      }else{
        debugPrint("Gym Not Found");
      }
    });
  }

  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  _checkGymOnDatabase(barcode.rawValue);
                }
              },
              overlay: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Scan QR Code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Place the QR Code inside the frame to scan it",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ],
              )
            ),
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
    );
  }
}