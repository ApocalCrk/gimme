// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';

class DetailTransactionScreen extends StatefulWidget {
  Map<String, dynamic> dataTransaction;
  DetailTransactionScreen({Key? key, required this.dataTransaction}) : super(key: key);

  @override
  State<DetailTransactionScreen> createState() => _DetailTransactionScreenState();
}

class _DetailTransactionScreenState extends State<DetailTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Icon(
                      Icons.check_circle_outline,
                      size: 50,
                      color: successColor.withGreen(200),
                    ),
                    const Text(
                      "Payment Successful",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      // "Your transaction has been successfully processed. Please check your email for the receipt.",
                      'Membership has appeared in your\naccount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        color: secondaryColor,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Recipient",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                widget.dataTransaction['name'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                DateTime.now().toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                "Rp. ${moneyFormat(int.parse(widget.dataTransaction['price']))},00",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 70),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text(
                                  "Dismiss",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}