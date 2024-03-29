import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/dashboard/slicing/maps.dart';
import 'package:gimme/screens/dashboard/slicing/shortcut.dart';
import 'package:gimme/screens/dashboard/slicing/subs.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget{
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = ScrollController();
  bool isScrolled = false;
  
  _scrollListener() {
    if (controller.offset >= 40) {
      setState(() {
        isScrolled = true;
      });
    } else {
      setState(() {
        isScrolled = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: isScrolled ?
          const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: lowSecondaryColor,
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ]
          )
          :
          null,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            child: AppBar(
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xffffffff),
              bottomOpacity: 0.0,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, ${dataUser['name']}!",
                        style: const TextStyle(
                          color: Color(0xff000000),
                          fontSize: 20,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        DateTime.now().hour < 12 ? "Good Morning, Let's Exercise!" : DateTime.now().hour < 18 ? "Good Afternoon, Let's Exercise!" : "Good Evening, Let's Exercise!",
                        style: const TextStyle(
                          color: Color(0xff707070),
                          fontSize: 15,
                          fontFamily: "Montserrat"
                        ),
                      )
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: secondaryColor,
                    backgroundImage: Image.network(dataUser['photoURL']).image,
                  )
                ],
              )
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Color(0xffD0ECFB), 
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Generate QR Code",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          const Text(
                            "Don't forget about your goal!",
                            style: TextStyle(
                              color: Color(0xff6F6F6F),
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, '/profile/membership');
                            },
                            child: const Text(
                              "My Membership",
                              style: TextStyle(
                                color: Color(0xff0094FF),
                                fontSize: 12,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                              decoration: const BoxDecoration(
                                color: Color(0xff60CEF8),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              child: const Text(
                                "Generate QR Code",
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.pushNamed(context, '/subs');
                            }
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -58,
                    left: MediaQuery.of(context).size.width / 2 - 40,
                    child: Transform.rotate(
                      angle: -0.2, 
                      child: Image.asset('assets/images/icon/phone.png'),
                    )
                  )
                ]
              )
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Quick Shortcut",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Shortcut(),
            const SizedBox(height: 5),
            const Subs(),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Visit Nearby Gyms",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 20,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/maps');
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent)
                    ),
                    child: const Text("Viem Maps",
                      style: TextStyle(
                        color: Color(0xff60CEF8),
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ],
              )
            ),
            const SizedBox(height: 10),
            const Maps(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}