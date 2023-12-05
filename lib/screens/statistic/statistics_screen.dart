import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  
  @override
  // ignore: library_private_types_in_public_api
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black.withOpacity(0.7),
                      size: 40
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  Text(
                    "Generate  QR",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 25,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(width: 30)
                ],
              ),
              const SizedBox(height: 20),


            ]
          )
        )
      )
    );
  }
}
    