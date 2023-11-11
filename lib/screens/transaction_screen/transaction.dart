import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:gimme/constants.dart';
import 'dart:math' as math;
import 'package:gimme/screens/transaction_screen/detail.transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';


class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> sendData;

  PaymentScreen({Key? key, required this.sendData})
      : super(key: key);

  @override
  _PaymentScreennState createState() => _PaymentScreennState();
}

class _PaymentScreennState extends State<PaymentScreen> {
  late ScrollController scrollController;

  SlidingUpPanelController panelController = SlidingUpPanelController();

  double minBound = 0.0;

  double upperBound = 1.0;

  Map<String, dynamic> data = {};

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    super.initState();
    getDetailGym(widget.sendData['id_gym']);
  }

  getDetailGym(id) async {
    await FirebaseFirestore.instance.collection('gym')
    .where('id_gym', isEqualTo: id)
    .get().then((value) {
        setState(() {
          data = value.docs[0].data();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = <String>[
      'Payment Method',
      'QR',
      'Transfer Bank',
    ];

    String dropdownValue = list.first;

    // if (listTransction == null) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    return Stack(
      children: [
        Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Icon(Icons.arrow_back_rounded,
                              color: Colors.black.withOpacity(0.7), size: 30),
                          onTap: () => Navigator.pop(context),
                        ),
                        Text(
                          "Payment Detail",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 25,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 30)
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          '${data['name']} | ${data['place']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Text(
                          'Payment Detail',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Text('To'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Text('${data['name']}'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Text('Amount'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Text('Rp ${moneyFormat(widget.sendData['price'])}'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Text('Type'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Text('${widget.sendData['type']}'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Text('Package'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Text('${widget.sendData['bundle']}'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Text('Duration'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Text(widget.sendData['type'] == 'Monthly'
                        ? '1 Month'
                        : '1 Year'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 145.0, bottom: 10.0),
                    child: DropdownMenu(
                      width: 380,
                      initialSelection: list.first,
                      onSelected: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      dropdownMenuEntries:
                          list.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'By purchasing this member, you have agreed to\nall the terms and conditions that apply\nto each gym member.',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
        SlidingUpPanelWidget(
          onStatusChanged: (value) async {
            if (value == SlidingUpPanelStatus.expanded) {
              Future.delayed(const Duration(seconds: 3)).then((value) {
                var transactionId = const Uuid().v5(Uuid.NAMESPACE_URL, 'gimme');
                FirebaseFirestore.instance.collection('transactions').add({
                  'transaction_id': transactionId,
                  'id_user': widget.sendData['id_user'],
                  'id_gym': widget.sendData['id_gym'],
                  'receipt': data['name'],
                  'type': widget.sendData['type'],
                  'bundle': widget.sendData['bundle'],
                  'price': widget.sendData['price'],
                  'payment_method': dropdownValue,
                  'date': DateTime.now(),
                }).then((value) {
                  Map<String, dynamic> detail = {
                    'transaction_id': transactionId,
                    'id_user': widget.sendData['id_user'],
                    'id_gym': widget.sendData['id_gym'],
                    'receipt': data['name'],
                    'type': widget.sendData['type'],
                    'bundle': widget.sendData['bundle'],
                    'price': widget.sendData['price'],
                    'payment_method': dropdownValue,
                    'date': DateTime.now(),
                  };
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailTransaksi(
                        detailTransaksi: detail,
                      )
                    )
                  );
                });
              });
            }
          },
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xFF505EDC),
              shadows: [
                BoxShadow(
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    color: const Color(0x11000000))
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: 60 * math.pi / 40,
                          child: Icon(
                            Icons.chevron_right,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Swipe up to send payment',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                Flexible(
                  child: Container(
                    color: Color(0xFF505EDC),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.rotate(
                                angle: -25.7,
                                child: Icon(
                                  Icons.send_sharp,
                                  color: Colors.white,
                                  size: 110.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sending Payment',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          controlHeight: 50.0,
          anchor: 0.4,
          minimumBound: minBound,
          upperBound: upperBound,
          panelController: panelController,
        ),
      ],
    );
  }
}
