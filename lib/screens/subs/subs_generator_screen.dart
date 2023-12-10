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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black
                    ),
                    onTap: () => Navigator.popAndPushNamed(context, '/dashboard', arguments: 0),
                  ),
                  const Text(
                    "Generator QR",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(width: 30)
                ],
              ),
              sizedBoxDefault,
              const Text(
                "Select Gym",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -20),
                child: SizedBox(
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
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}