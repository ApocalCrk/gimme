import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Personal Data',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Gimme menggunakan informasi ini untuk verifikasi identitas Anda dan Menjaga Keamanan komunitas kami.Anda yang menentukan detail pribadi yang dapat dilihat orang lain.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: "Montserrat",
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ShaderMask(
                                          blendMode: BlendMode.srcIn,
                                          shaderCallback: (rect) =>
                                              LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFF9DCEFF),
                                              Color(0xFF92A3FD)
                                            ],
                                          ).createShader(rect),
                                          child: Text(
                                            "Personal Data",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5, bottom: 10),
                                        child: Text(
                                          "+6287812345678",
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 15,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 10,left: 10),
                                        child: ShaderMask(
                                          blendMode: BlendMode.srcIn,
                                          shaderCallback: (rect) =>
                                              LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFF9DCEFF),
                                              Color(0xFF92A3FD)
                                            ],
                                          ).createShader(rect),
                                          child: Text(
                                            "Date of Birth",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                                        child: Text(
                                          "15/Oct/2003",
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 15,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 10, top: 10),
                                        child: ShaderMask(
                                          blendMode: BlendMode.srcIn,
                                          shaderCallback: (rect) =>
                                              LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFF9DCEFF),
                                              Color(0xFF92A3FD)
                                            ],
                                          ).createShader(rect),
                                          child: Text(
                                            "Address",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5, bottom: 10),
                                        child: Text(
                                          "Jl.pegangsaan timur no.56",
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 15,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: ShaderMask(
                                          blendMode: BlendMode.srcIn,
                                          shaderCallback: (rect) =>
                                              LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFF9DCEFF),
                                              Color(0xFF92A3FD)
                                            ],
                                          ).createShader(rect),
                                          child: Text(
                                            "Height",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5, bottom: 10),
                                        child: Text(
                                          "180 Cm",
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 15,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: ShaderMask(
                                          blendMode: BlendMode.srcIn,
                                          shaderCallback: (rect) =>
                                              LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFF9DCEFF),
                                              Color(0xFF92A3FD)
                                            ],
                                          ).createShader(rect),
                                          child: Text(
                                            "Weight",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5, bottom: 10),
                                        child: Text(
                                          "90 Kg",
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 15,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
