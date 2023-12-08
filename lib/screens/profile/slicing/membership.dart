import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/profile/controller/profileController.dart';
import 'package:gimme/screens/profile/model/profile.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}
class _MembershipScreenState extends State<MembershipScreen> {@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Membership',
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
              margin: const EdgeInsets.only(left: 30, right: 30,top: 20),
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
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 15,bottom: 15),
                  child:  CircleAvatar(
                    radius: 30,
                    backgroundImage: dataUser['photoURL'] != null
                        ? NetworkImage(dataUser['photoURL'])
                        :
                        NetworkImage(
                        "https://cdn0-production-images-kly.akamaized.net/tLqQ9BQmDFMQIEm7gYIpZ4jik-4=/0x41:783x482/800x450/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3551902/original/078763900_1629962940-chika01.JPG"),
                  ),
                ),
                SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      dataUser['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5, left: 1),
                    child: Text(
                      "Lose a Fat Program",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
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
              ],
            ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30,top: 20),
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
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 15,bottom: 15),
                  child:  CircleAvatar(
                    radius: 30,
                    backgroundImage: dataUser['photoURL'] != null
                        ? NetworkImage(dataUser['photoURL'])
                        :
                        NetworkImage(
                        "https://cdn0-production-images-kly.akamaized.net/tLqQ9BQmDFMQIEm7gYIpZ4jik-4=/0x41:783x482/800x450/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3551902/original/078763900_1629962940-chika01.JPG"),
                  ),
                ),
                SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      dataUser['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5, left: 1),
                    child: Text(
                      "Lose a Fat Program",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
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
              ],
            ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30,top: 20),
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
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 15,bottom: 15),
                  child:  CircleAvatar(
                    radius: 30,
                    backgroundImage: dataUser['photoURL'] != null
                        ? NetworkImage(dataUser['photoURL'])
                        :
                        NetworkImage(
                        "https://cdn0-production-images-kly.akamaized.net/tLqQ9BQmDFMQIEm7gYIpZ4jik-4=/0x41:783x482/800x450/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3551902/original/078763900_1629962940-chika01.JPG"),
                  ),
                ),
                SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      dataUser['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5, left: 1),
                    child: Text(
                      "Lose a Fat Program",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
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
              ],
            ),
            )
          ],
        )
      ),
    );
  }
}
