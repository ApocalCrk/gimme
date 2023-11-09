import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  
  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? selectedImage;

  getImage() async {
    bool? isCamera = await showDialog(
      context: context,
      builder: (context) => SlidingUpPanel(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
        minHeight: MediaQuery.of(context).size.height * 0.15,
        maxHeight: MediaQuery.of(context).size.height * 0.15,
        panel: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Select Image",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)
                      )
                    )
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Text(
                      "Camera",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)
                      )
                    )
                  ),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Text(
                      "Gallery",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );

    if (isCamera == null) return;

    XFile? file = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    selectedImage = File(file!.path);
    final List<int> imageBytes = await selectedImage!.readAsBytes();
    final String base64Image = base64Encode(imageBytes);
    FirebaseFirestore.instance.collection('users').doc(dataUser['uid']).update({
      'profilepicture': base64Image
    });
    setState(() {
      dataUser['photoURL'] = base64Image;
    });
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 25,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: secondaryColor,
                          backgroundImage: Image.memory(base64Decode(dataUser['photoURL']), gaplessPlayback: true).image,
                          radius: 30,
                        ),
                        onTap: () {
                          getImage();
                        },
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataUser['username'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            dataUser['email'],
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ]
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)
                        )
                      )
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile/edit');
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: const Text(
                        "Edit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ],
              ),


            ]
          )
        )
      )
    );
  }
}
    