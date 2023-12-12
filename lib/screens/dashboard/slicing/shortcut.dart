import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/dashboard/slicing/panel.dart';
import 'package:gson/gson.dart';

// ignore: must_be_immutable
class Shortcut extends StatelessWidget {
  const Shortcut({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataUser['shortcuts'].length + 1,
        itemBuilder: (context, index) {
          return 
          index == dataUser['shortcuts'].length ?
          InkWell(
            onTap: () {
               panelController.open();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: lowSecondaryColor,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Center(
                    child: Icon(Icons.add, color: Colors.white, size: 30)
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                )
              ],
            ),
          )
          :
          GestureDetector(
            onTap: () {
              tempDataPlan = {
                "id_workout": int.parse(dataUser['shortcuts'][index+1]!["id_workout"]!),
                "exercise_name": dataUser['shortcuts'][index+1]!["exercise_name"]!,
                "kalori": dataUser['shortcuts'][index+1]!["kalori"]!,
                "duration": dataUser['shortcuts'][index+1]!["duration"]!,
                "status": "start"
              };
              Navigator.pushNamed(context, '/dashboard', arguments: 1);
            },
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(int.parse(dataUser['shortcuts'][index+1]!["Color"]!)),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: Image.asset(dataUser['shortcuts'][index+1]!["icon"]!, width: 30, height: 30)
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  child: Text(
                    dataUser['shortcuts'][index + 1]!["title"]!,
                    style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class AllShortcut extends StatelessWidget {
  Map<int, Map<dynamic, String>> shortcut;
  AllShortcut({super.key, required this.shortcut});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFAED6F3),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: Image.asset("assets/images/icon/gym.png", width: 30, height: 30)
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  child: const Text(
                    "Gym",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFAFB2EC),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: Image.asset("assets/images/icon/diet.png", width: 30, height: 30)
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  child: const Text(
                    "Diet",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCF3AE),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: Image.asset("assets/images/icon/yoga.png", width: 30, height: 30)
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  child: const Text(
                    "Yoga",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3AEBA),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: Image.asset("assets/images/icon/cardio.png", width: 30, height: 30)
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  child: const Text(
                    "Cardio",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ), 
        sizedBoxDefault,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                var lastKey = shortcut.keys.reduce((a, b) => a > b ? a : b);
                dataUser['shortcuts'][lastKey + 1] = {
                  "icon": "assets/images/icon/cycling.png",
                  "title": "Cycling",
                  "Color": "0xFFAED6F3",
                  "id_workout": "1",
                  "exercise_name": "Cycling",
                  "kalori": "355",
                  "duration": "1"
                };
                shortcut = dataUser['shortcuts'];
                panelController.close();
                SharedPref.saveStr("shortcuts", gson.encode(dataUser['shortcuts']));
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.popAndPushNamed(context, '/dashboard', arguments: 0);
                });
              },
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFAED6F3),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Image.asset("assets/images/icon/cycling.png", width: 30, height: 30)
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 15),
                    child: const Text(
                      "Cycling",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                var lastKey = shortcut.keys.reduce((a, b) => a > b ? a : b);
                dataUser['shortcuts'][lastKey + 1] = {
                  "icon": "assets/images/icon/lifting.png",
                  "title": "Lifting",
                  "Color": "0xFFAFB2EC",
                  "id_workout": "1",
                  "exercise_name": "Lifting",
                  "kalori": "355",
                  "duration": "1"
                };
                shortcut = dataUser['shortcuts'];
                panelController.close();
                SharedPref.saveStr("shortcuts", gson.encode(dataUser['shortcuts']));
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.popAndPushNamed(context, '/dashboard', arguments: 0);
                });
              },
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFAFB2EC),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Image.asset("assets/images/icon/lifting.png", width: 30, height: 30)
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 15),
                    child: const Text(
                      "Lifting",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                var lastKey = shortcut.keys.reduce((a, b) => a > b ? a : b);
                dataUser['shortcuts'][lastKey + 1] = {
                  "icon": "assets/images/icon/pilates.png",
                  "title": "Pilates",
                  "Color": "0xFFCCF3AE",
                  "id_workout": "1",
                  "exercise_name": "Pilates",
                  "kalori": "355",
                  "duration": "1"
                };
                shortcut = dataUser['shortcuts'];
                panelController.close();
                SharedPref.saveStr("shortcuts", gson.encode(dataUser['shortcuts']));
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.popAndPushNamed(context, '/dashboard', arguments: 0);
                });
              },
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCF3AE),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Image.asset("assets/images/icon/pilates.png", width: 30, height: 30)
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 15),
                    child: const Text(
                      "Pilates",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                var lastKey = shortcut.keys.reduce((a, b) => a > b ? a : b);
                dataUser['shortcuts'][lastKey + 1] = {
                  "icon": "assets/images/icon/zumba.png",
                  "title": "Zumba",
                  "Color": "0xFFF3AEBA",
                  "id_workout": "1",
                  "exercise_name": "Zumba",
                  "kalori": "355",
                  "duration": "1"
                };
                shortcut = dataUser['shortcuts'];
                panelController.close();
                SharedPref.saveStr("shortcuts", gson.encode(dataUser['shortcuts']));
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.popAndPushNamed(context, '/dashboard', arguments: 0);
                });
              },
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3AEBA),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Image.asset("assets/images/icon/zumba.png", width: 30, height: 30)
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 15),
                    child: const Text(
                      "Zumba",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}