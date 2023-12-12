 import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xffffffff),
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Contact Us",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              shrinkWrap: true,
              itemCount: contact.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse("https://www.instagram.com/${contact[index]["instagram"]}"));
                  },
                  child: Card(
                    color: lowPrimaryColor.withAlpha(50),
                    elevation: 0.0,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          "assets/images/icon/instagram.png",
                          width: 30,
                          height: 30,
                        )
                      ),
                      title: Text(
                        contact[index]["name"],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text(
                        contact[index]["instagram"],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
            const Column(
              children: [
                Text(
                  "Gimme is an application that helps you to exercise and maintain your health",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Version 1.0.0",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}