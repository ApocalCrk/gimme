import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';

class Subs extends StatelessWidget {
  const Subs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 200,
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
                Positioned(
                  top: 18,
                  left: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Get\nMembership",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const Text(
                        "Practices anytime\nAnywhere at any Gym",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.only(left: 35, right: 35, top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset("assets/images/icon/gym-tool.png", width: 200, height: 200)
                )
              ],
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 200,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: lowPrimaryColor,
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
                Positioned(
                  top: 18,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Get\nMembership",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const Text(
                        "Practices anytime\nAnywhere at any Gym",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.only(left: 35, right: 35, top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset("assets/images/icon/gym-tool.png", width: 200, height: 200)
                )
              ],
            ),
          ]
        ),
      ),
    );
  }
}