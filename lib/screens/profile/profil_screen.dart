import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30, top: 30),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "https://cdn0-production-images-kly.akamaized.net/tLqQ9BQmDFMQIEm7gYIpZ4jik-4=/0x41:783x482/800x450/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3551902/original/078763900_1629962940-chika01.JPG"),
                  ),
                ),
                SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Yesica Tamara",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, left: 1),
                    child: Text(
                      "Lose a Fat Program",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  )
                ]),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 15, right: 33),
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF9DCEFF),
                        Color(0xFF92A3FD)
                      ], // Ganti warna sesuai keinginan
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 3),
                  width: 90,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (rect) => LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                        ).createShader(rect),
                        child: Text(
                          "180 Cm",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Height",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 3),
                  width: 90,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (rect) => LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                        ).createShader(rect),
                        child: Text(
                          "65 Kg",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Weight",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 3),
                  width: 90,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (rect) => LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                        ).createShader(rect),
                        child: Text(
                          "22 Yo",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Age",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              "Account",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (rect) => LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                              ).createShader(rect),
                              child: Icon(
                                Icons.person_outline_rounded,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Personal Data",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              onPressed: () =>
                              Navigator.pushNamed(context, "/profile/personal_data"),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (rect) => LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                              ).createShader(rect),
                              child: Icon(
                                Icons.sticky_note_2_outlined,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Achievement",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
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
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (rect) => LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                              ).createShader(rect),
                              child: Icon(
                                Icons.local_activity_outlined,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Activity History",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
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
                      Container(
                        padding: EdgeInsets.only(left: 15.0, bottom: 20),
                        child: Row(
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (rect) => LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                              ).createShader(rect),
                              child: Icon(
                                Icons.wallet_membership_outlined,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Personal Data",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
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
                )
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Notification",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, bottom: 20),
                        child: Row(
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (rect) => LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                              ).createShader(rect),
                              child: Icon(
                                Icons.person_outline_rounded,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Personal Data",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 43,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF9DCEFF),
                                    Color(0xFF92A3FD)
                                  ], // Ganti warna sesuai keinginan
                                ),
                              ),
                              child: Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                },
                                activeTrackColor: Colors.transparent,
                                activeColor: Colors.white,
                                inactiveTrackColor: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              "Other",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (rect) => LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                              ).createShader(rect),
                              child: Icon(
                                Icons.mail_outline_rounded,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Contact Us",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
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
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (rect) => LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                              ).createShader(rect),
                              child: Icon(
                                Icons.shield_moon_outlined,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
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
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (rect) => LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                              ).createShader(rect),
                              child: Icon(
                                Icons.settings_outlined,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Settings",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
