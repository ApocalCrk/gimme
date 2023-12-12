import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/controller/generatorController.dart';

class SubsGeneratorScreen extends StatefulWidget {
  const SubsGeneratorScreen({Key? key}) : super(key: key);

  
  @override
  // ignore: library_private_types_in_public_api
  _SubsGeneratorScreenState createState() => _SubsGeneratorScreenState();
}

class _SubsGeneratorScreenState extends State<SubsGeneratorScreen> {
  List<dynamic> dataMembership = [];

  showMembership(uid) async {
    var allData = await GeneratorController().showAllMembership(uid);
    setState(() {
      dataMembership = allData;
    });
  }

  @override
  void initState() {
    super.initState();
    showMembership(dataUser['uid']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "Generator QR",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Gym",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(height: 10),
              dataMembership.isEmpty ?
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: lowSecondaryColor,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ]
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'You don\'t have any membership',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'You can buy membership in the gym that you want to join',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          )
                        )
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/dashboard', arguments: 3);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          'Find Gym',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
              :
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: dataMembership.length,
                  itemBuilder: ((context, index) {
                    return Container(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dataMembership[index]['gym']['name'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                dataMembership[index]['gym']['place'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              dataMembership[index]['qrCheck'] == true ?
                              Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Text(
                                    "Code Expired in ${dataMembership[index]['qrCheckTime']}",
                                    style: const TextStyle(
                                      color: errorColor,
                                      fontSize: 12,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              )
                              :
                              const SizedBox()
                            ],
                          ),
                          dataMembership[index]['qrCheck'] == true ?
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30, bottom: MediaQuery.of(context).size.height / 30),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Text(
                                "On Going",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600
                                ),
                              )
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/subs/generate', arguments: dataMembership[index]['qrCheckId']);
                            },
                          )
                          :
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30, bottom: MediaQuery.of(context).size.height / 30),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Text(
                                "Generate",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600
                                ),
                              )
                            ),
                            onTap: () {
                              GeneratorController().generateQrCode(dataMembership[index]['id']).then((value) {
                                Navigator.pushNamed(context, '/subs/generate', arguments: value['id_qr']);
                              });
                            },
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}