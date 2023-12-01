import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/dashboard/slicing/shortcut.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final panelController = PanelController();
class Panel extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  const Panel(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sizedBoxDefault,
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Shortcuts",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600
                ),
              ),
              InkWell(
                onTap: () {
                  panelController.close();
                },
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 15,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),
        ),
        sizedBoxDefault,
        AllShortcut(shortcut: dataUser['shortcuts'])
      ],
    );
  }
}