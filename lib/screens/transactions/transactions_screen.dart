// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/controller/transactionController.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:gimme/data/Transaction.dart';

class TransactionScreen extends StatefulWidget {
  final Map<String, dynamic> dataTransaction;
  const TransactionScreen({Key? key, required this.dataTransaction}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final panelController = PanelController();
  bool panel_open = false;
  bool dragPanel = false;
  bool isPanelSlide = false;
  bool onProgress = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary2Color.withGreen(400),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Payment Detail",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                              fontSize: 24,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: primaryColor,
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        widget.dataTransaction['name']+'\n'+widget.dataTransaction['place'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: secondaryColor,
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Rp. ${moneyFormat(int.parse(widget.dataTransaction['price']))},00",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Montserrat",
                          fontSize: 30,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              const Text(
                                "To",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                widget.dataTransaction['name'],
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            ]
                          ),
                          const TableRow(
                            children: [
                              SizedBox(height: 20),
                              SizedBox(height: 20)
                            ]
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Amount",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                "Rp. ${moneyFormat(int.parse(widget.dataTransaction['price']))},00",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            ]
                          ),
                          const TableRow(
                            children: [
                              SizedBox(height: 20),
                              SizedBox(height: 20)
                            ]
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Type",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                widget.dataTransaction['type'],
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            ]
                          ),
                          const TableRow(
                            children: [
                              SizedBox(height: 20),
                              SizedBox(height: 20)
                            ]
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Bundle",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                "${widget.dataTransaction['bundle']}",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            ]
                          ),
                          const TableRow(
                            children: [
                              SizedBox(height: 20),
                              SizedBox(height: 20)
                            ]
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Duration",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              widget.dataTransaction['status'] == 'update' ?
                              Text(
                                "${widget.dataTransaction['duration_update']}",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ) :
                              Text(
                                "${widget.dataTransaction['duration']}",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            ]
                          ),
                        ],
                      )
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: secondaryColor, width: 1.5)
                          ),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              icon: const SizedBox.shrink(),
                              borderRadius: BorderRadius.circular(10),
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              ),
                              isExpanded: true,
                              hint: const Text(
                                "Select Payment Method",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              items: payment_method.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Montserrat",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  widget.dataTransaction['payment_method'] = value;
                                  dragPanel = true;
                                });
                              },
                              value: widget.dataTransaction['payment_method'],
                            ),
                          ),
                        ),
                      ),
                      sizedBoxDefault,
                      const Text(
                        "By purchasing this member, you have agreed to all the terms and conditions that apply to each gym member.",
                        textAlign: TextAlign.center,
                          style: TextStyle(
                          color: secondaryColor,
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SlidingUpPanel(
            controller: panelController,
            minHeight: MediaQuery.of(context).size.height * 0.1,
            maxHeight: MediaQuery.of(context).size.height,
            boxShadow: null,
            isDraggable: dragPanel,
            color: primary2Color.withGreen(400),
            onPanelSlide: (pos) {
              setState(() {
                if(pos > 0) {
                  isPanelSlide = true;
                } else {
                  isPanelSlide = false;
                }
              });
            },
            onPanelOpened: () {
              setState(() {
                dragPanel = false;
                panel_open = true;
              });
              var dataTemp = widget.dataTransaction;
              Transaction transaction = Transaction(
                id_transaction: widget.dataTransaction['status'] == 'update' ? widget.dataTransaction['id_transaction'] : generateIDTransaction(),
                uid: int.parse(dataUser['uid'].toString()),
                id_gym: dataTemp['id_gym'],
                payment_method: dataTemp['payment_method'],
                payment_status: "Paid",
                payment_amount: int.parse(dataTemp['price']),
                bundle: dataTemp['bundle'],
                type_membership: widget.dataTransaction['status'] == 'update' ? dataTemp['duration_update'] : dataTemp['duration'],
              );
              widget.dataTransaction['status'] == 'update' ?
              TransactionController().updateTransaction(transaction).then((value) {
                var val = jsonDecode(value!);
                if(val['status'] == 'success'){
                  onProgress = true;
                  transaction.gym = val['data']['gym'];
                  transaction.membership = val['data']['membership'];
                  transaction.created_at = DateTime.parse(val['data']['created_at']);
                  transaction.updated_at = DateTime.parse(val['data']['updated_at']);
                  Future.delayed(const Duration(seconds: 2)).then((_) {
                    Navigator.pushReplacementNamed(context, '/gym/checkout/success', arguments: transaction);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Payment Failed"),
                      backgroundColor: Colors.red,
                    )
                  );
                  Navigator.pop(context);
                }
              })
              :
              TransactionController().sendTransaction(transaction).then((value) {
                var val = jsonDecode(value!);
                if(val['status'] == 'success'){
                  onProgress = true;
                  transaction.gym = val['data']['gym'];
                  transaction.membership = val['data']['membership'];
                  transaction.created_at = DateTime.parse(val['data']['created_at']);
                  transaction.updated_at = DateTime.parse(val['data']['updated_at']);
                  Future.delayed(const Duration(seconds: 2)).then((_) {
                    Navigator.pushReplacementNamed(context, '/gym/checkout/success', arguments: transaction);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Payment Failed"),
                      backgroundColor: Colors.red,
                    )
                  );
                  Navigator.pop(context);
                }
              });
            },
            onPanelClosed: () {
              setState(() {
                panel_open = false;
              });
            },
            panel: 
            panel_open ?
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/images/icon/success_pay.json',
                    repeat: false
                  ),
                  Text(
                    onProgress ? "Please wait..." : "Payment Success",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 25,
                      fontWeight: FontWeight.w600
                    ),
                  )
                ],
              ),
            )
            :
            Column(
              children: [
                Icon(
                  isPanelSlide ?
                  Icons.keyboard_arrow_down_rounded : 
                  Icons.keyboard_arrow_up_rounded,
                  size: 50,
                  color: Colors.white,
                ),
                Text(
                  isPanelSlide ?
                  'Swipe down to cancel payment' :
                  'Swipe up to send payment',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                )
              ]
            )
          ),
        ],
      ),
    );
  }
}