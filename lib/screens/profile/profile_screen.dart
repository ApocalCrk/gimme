// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print
import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/auth/model/User.dart';
import 'package:gimme/screens/profile/controller/profileController.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = ProfileController();
  File? selectedimage;
  String? selectedImageBase64;
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    int age = calculateAndPrintAge(dataUser);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Profile",
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
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: ExtendedImage.network(dataUser['photoURL']).image,
                        ),
                        const SizedBox(width: 10),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            dataUser['name'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            checkUser(dataUser['created_at']),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: "Montserrat",
                            ),
                          )
                        ]),
                      ],
                    ),
                    Container(
                      width: 90,
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: primary2Color,
                      ),
                      child: TextButton(
                        onPressed: () => showImagePickerOption(context),
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
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Text(
                            '${dataUser['height']} Cm',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: primary2Color
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
                          Text(
                           "${dataUser['weight']} Kg ",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: primary2Color,
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
                          Text(
                            "$age Yo",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: primary2Color
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
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/profile/personal_data");
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_outline_rounded,
                                  size: 30,
                                  color: primary2Color,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Personal Data",
                                  style: TextStyle(
                                    color: Colors.black,
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
                                    color: Colors.black,
                                  ),
                                  onPressed: () =>
                                  Navigator.pushNamed(context, "/profile/personal_data"),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:() {
                            Navigator.pushNamed(context, "/profile/transaction_history");
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.sticky_note_2_outlined,
                                  size: 30,
                                  color: primary2Color
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Transaction History",
                                  style: TextStyle(
                                    color: Colors.black,
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
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/profile/transaction_history");
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/profile/activity_history");
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_activity_outlined,
                                  size: 30,
                                  color: primary2Color
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Activity History",
                                  style: TextStyle(
                                    color: Colors.black,
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
                                    color: Colors.black,
                                  ),
                                  onPressed: () =>
                                  Navigator.pushNamed(context, "/profile/activity_history"),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/profile/membership");
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.wallet_membership_outlined,
                                  size: 30,
                                  color: primary2Color
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Membership",
                                  style: TextStyle(
                                    color: Colors.black,
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
                                    color: Colors.black,
                                  ),
                                  onPressed: () =>
                                  Navigator.pushNamed(context, "/profile/membership"),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/profile/todo");
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 15.0, bottom: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_box_outlined,
                                  size: 30,
                                  color: primary2Color
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Daily Plan",
                                  style: TextStyle(
                                    color: Colors.black,
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
                                    color: Colors.black,
                                  ),
                                  onPressed: () =>
                                  Navigator.pushNamed(context, "/profile/todo"),
                                )
                              ],
                            ),
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
                    margin: const EdgeInsets.only(left: 20, right: 20),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/profile/contact_us");
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.mail_outline_rounded,
                                  size: 30,
                                  color: primary2Color
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Contact Us",
                                  style: TextStyle(
                                    color: Colors.black,
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
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/profile/contact_us");
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/profile/privacy_policy");
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.shield_moon_outlined,
                                  size: 30,
                                  color: primary2Color
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                    color: Colors.black,
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
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/profile/privacy_policy");
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Log Out", 
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: const Text("Are you sure want to log out?", 
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        SharedPreferences.getInstance().then((value) => value.clear());
                                        Navigator.pop(context);
                                        Navigator.pushNamedAndRemoveUntil(context, "/auth", (route) => false);
                                      },
                                      child: const Text("Log Out",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 30,
                                  color: primary2Color
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Log out",
                                  style: TextStyle(
                                    color: Colors.black,
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
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Log Out", 
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          content: const Text("Are you sure want to log out?", 
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                SharedPreferences.getInstance().then((value) => value.clear());
                                                Navigator.pop(context);
                                                Navigator.pushNamedAndRemoveUntil(context, "/auth", (route) => false);
                                              },
                                              child: const Text("Log Out",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  int calculateAndPrintAge(Map<dynamic, dynamic> dataUser) {
    String dateOfBirthString = dataUser['dateofbirth'];
    DateTime dateOfBirth = DateTime.parse(dateOfBirthString);

    int age = _calculateAge(dateOfBirth);
    return age;
  }

  int _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> _fromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        print("User canceled image selection");
        return;
      }
      selectedimage = File(image.path);
      ProfileController.updatePhoto(int.parse(dataUser["uid"].toString()), selectedimage!).then((value) async {
        User userId = await profileController.findById(int.parse(dataUser["uid"].toString()));
        setState(() {
          SharedPref.saveStr('photoURL', userId.photoUrl!);
          dataUser['photoURL'] = userId.photoUrl!;
        });
      });
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: successColor,
          content: Text("Photo profile updated")
        ),
      );
    } catch (e) {
      print("Error selecting image from gallery: $e");
    }
  }

  Future<void> _fromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) {
        print("User canceled camera capture");
        return;
      }
      selectedimage = File(image.path);
      ProfileController.updatePhoto(int.parse(dataUser["uid"].toString()), selectedimage!).then((value) async {
        User userId = await profileController.findById(int.parse(dataUser["uid"].toString()));
        setState(() {
          SharedPref.saveStr('photoURL', userId.photoUrl!);
          dataUser['photoURL'] = userId.photoUrl!;
        });
      });

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: successColor,
          content: Text("Photo profile updated")
        ),
      );
    } catch (e) {
      print("Error capturing image from camera: $e");
    }
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 150,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.01,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3.0, top: 10.0),
                  child: ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Camera"),
                    onTap: () {
                      _fromCamera();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Gallery"),
                    onTap: () {
                      _fromGallery();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
