import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/dashboard/dashboard.dart';
import 'package:gimme/screens/dashboard/slicing/dashboard_screen.dart';
import 'package:gimme/screens/workouts/workouts_sreen.dart';
import 'package:uuid/uuid.dart';
import 'package:gimme/screens/transaction_screen/for_pdf/pdf_view.dart';

class DetailTransaksi extends StatefulWidget {
  final Map<String, dynamic>? detailTransaksi;
  const DetailTransaksi({Key? key, this.detailTransaksi})
      : super(key: key);

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  // ignore: non_constant_identifier_names
  Container generate_barcode(String id) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: BarcodeWidget(
            data: id,
            width: 200.0,
            height: 60.0,
            barcode: Barcode.code128(escapes: true),
            drawText: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // waiting reterieve data from firebase

    // if (listToTransction == null) {
    //   return Expanded(
    //     child: Container(
    //       decoration: ShapeDecoration(
    //         color: Color(0xFF505EDC),
    //         shadows: [
    //           BoxShadow(
    //               blurRadius: 5.0,
    //               spreadRadius: 2.0,
    //               color: const Color(0x11000000))
    //         ],
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(10.0),
    //             topRight: Radius.circular(10.0),
    //           ),
    //         ),
    //       ),
    //       child: Column(
    //         children: [
    //           Flexible(
    //             child: Container(
    //               color: Color(0xFF505EDC),
    //               child: Center(
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Transform.rotate(
    //                           angle: -25.7,
    //                           child: Icon(
    //                             Icons.send_sharp,
    //                             color: Colors.white,
    //                             size: 110.0,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     SizedBox(
    //                       height: 70.0,
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Text(
    //                           'Sending Payment',
    //                           style: TextStyle(
    //                               fontSize: 25,
    //                               fontWeight: FontWeight.w500,
    //                               color: Colors.white),
    //                         )
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //         mainAxisSize: MainAxisSize.min,
    //       ),
    //     ),
    //   );
    // }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF505EDC),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 350.0,
                height: 450.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline_outlined,
                            color: Colors.green,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Payment Successful',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Membership has appeared in your \n account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recipient',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.detailTransaksi!['receipt'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Date',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.detailTransaksi!['date'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Rp ${moneyFormat(widget.detailTransaksi!['price'])}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment ID',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.detailTransaksi!['transaction_id'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                      child: generate_barcode(widget.detailTransaksi!['transaction_id'].toString()),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                      child: TextButton(
                        child: const Text(
                          'Dismiss',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF60CEF8)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Dashboard()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 175.0,
                  child: TextButton(
                      onPressed: () {
                        createPdf(widget.detailTransaksi!, context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'Create PDF',
                        style: TextStyle(
                            color: Color(0xFF60CEF8),
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
