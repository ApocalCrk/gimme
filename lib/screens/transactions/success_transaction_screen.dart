// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/data/Transaction.dart';
import 'package:gimme/screens/transactions/print/pdf.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DetailTransactionScreen extends StatefulWidget {
  Transaction dataTransaction;
  DetailTransactionScreen({Key? key, required this.dataTransaction}) : super(key: key);

  @override
  State<DetailTransactionScreen> createState() => _DetailTransactionScreenState();
}

class _DetailTransactionScreenState extends State<DetailTransactionScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        backgroundColor: primary2Color.withGreen(400),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: successColor.withAlpha(200),
                            width: 3
                          )
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: successColor.withAlpha(200),
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                  widget.dataTransaction.gym!['name'],
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
                                  "Payment Date",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Montserrat",
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  formatStringDate(widget.dataTransaction.updated_at.toString()),
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
                                  "Rp. ${moneyFormat(widget.dataTransaction.payment_amount)},00",
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
                                  "Payment ID",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Montserrat",
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  widget.dataTransaction.id_transaction.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Montserrat",
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 50),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/gym/detail', arguments: {'id': widget.dataTransaction.gym!['id_gym']});
                                },
                                child: const Text(
                                  "Back",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Share.share(
                                'Check out my transaction on Gimme!\n\n'
                                'Recipient: ${widget.dataTransaction.gym!['name']}\n'
                                'Payment Date: ${formatStringDate(widget.dataTransaction.updated_at.toString())}\n'
                                'Amount: Rp. ${moneyFormat(widget.dataTransaction.payment_amount)},00\n'
                                'Payment ID: ${widget.dataTransaction.id_transaction.toString()}\n\n'
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
                              generateInvoice(widget.dataTransaction, context);
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
                                "storage/emulated/0/Download/${widget.dataTransaction.id_transaction.toString()}.png",
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}