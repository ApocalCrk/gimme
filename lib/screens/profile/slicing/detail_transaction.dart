// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/data/Transaction.dart';
import 'package:gimme/screens/transactions/print/pdf.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DetailPayment extends StatelessWidget {
  Map<String, dynamic> dataTransaction = {};
  DetailPayment({super.key, required this.dataTransaction});
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detail Transaction",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  Text(
                    dataTransaction['gym']['name'],
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Thank you for your payment at ${dataTransaction['gym']['name']}, your QR code already can be used to enter the gym.',
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Transaction ID',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  Text(
                    dataTransaction['id_transaction'].toString(),
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Date of Transaction',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  Text(
                    formatStringDate(dataTransaction['created_at']),
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Total Payment',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  Text(
                    'Rp. ${moneyFormat(dataTransaction['payment_amount'])},00',
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Payment Method',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  Text(
                    dataTransaction['payment_method'],
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Bundle',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        dataTransaction['bundle'],
                        style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '(${dataTransaction['type_membership']})',
                        style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Share.share(
                            'Check out my transaction on Gimme!\n\n'
                            'Recipient: ${dataTransaction['gym']['name']}\n'
                            'Payment Date: ${formatStringDate(dataTransaction['created_at'])}\n'
                            'Amount: Rp. ${moneyFormat(dataTransaction['payment_amount'])},00\n'
                            'Download Gimme now on Play Store!',
                            subject: 'Check out my transaction on Gimme!',
                          );
                        },
                        icon: const Icon(
                          Icons.share_rounded,
                          color: secondaryColor,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          Transaction transaction = Transaction.fromJson(dataTransaction);
                          generateInvoice(transaction, context);
                        },
                        icon: const Icon(
                          Icons.print_rounded,
                          color: secondaryColor,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          _screenshotController.captureAndSave(
                            "storage/emulated/0/Download/${dataTransaction['id_transaction']}.png",
                            pixelRatio: 3
                          ).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Screenshot saved to gallery"),
                                backgroundColor: successColor,
                              )
                            );
                          });
                        },
                        icon: const Icon(
                          Icons.download_rounded,
                          color: secondaryColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}