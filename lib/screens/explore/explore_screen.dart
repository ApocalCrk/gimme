import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:gimme/screens/dashboard/slicing/dashboard_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController controllerSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
          child:
              Column(
                children: [Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: const Offset(0, 0)
                          )
                        ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Location",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 15,
                                  fontFamily: "Montserrat"
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                        "Kalasan, Sleman",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 15,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.bold
                                        ),
                                  ),
                                ],
                              ),
                            ],

                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 40,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.black.withOpacity(0.7),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    SizedBox(height: 24),
                    TextFormField(
                      controller: controllerSearch,
                      decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                                    onPressed: () => Navigator.pushNamed(context, "/explore/qrScanner") ,
                                    icon: Icon(
                                      Icons.qr_code_scanner,
                                      color: Colors.black.withOpacity(0.7),
                                      size: 30,
                                    ),
                                  ),
                      labelText: "Search Here...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      )
    );
  }
}