import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/auth/model/User.dart';
import 'package:gimme/screens/profile/controller/profileController.dart';
import 'package:gimme/screens/profile/model/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 100),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 30),
                  Text(
                    "Profile",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 30)
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                              dataUser['photoURL']))),
                  SizedBox(width: 10),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
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
                    margin:
                        const EdgeInsets.only(top: 30, bottom: 15, right: 33),
                    width: 90,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                      ),
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
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (rect) => LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                            ).createShader(rect),
                            child: Text(
                              '${dataUser['height']} Cm',
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
                              "${dataUser['weight']} Kg ",
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
                              "$age Yo",
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
                        Container(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (rect) => LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF9DCEFF),
                                    Color(0xFF92A3FD)
                                  ],
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
                                onPressed: () => Navigator.pushNamed(
                                    context, "/profile/personal_data"),
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
                                  colors: [
                                    Color(0xFF9DCEFF),
                                    Color(0xFF92A3FD)
                                  ],
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
                                  colors: [
                                    Color(0xFF9DCEFF),
                                    Color(0xFF92A3FD)
                                  ],
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
                                onPressed: () => Navigator.pushNamed(
                                    context, "/profile/activity_history"),
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
                                  colors: [
                                    Color(0xFF9DCEFF),
                                    Color(0xFF92A3FD)
                                  ],
                                ).createShader(rect),
                                child: Icon(
                                  Icons.wallet_membership_outlined,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Membership",
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
                                onPressed: () => Navigator.pushNamed(
                                    context, "/profile/membership"),
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
                                  colors: [
                                    Color(0xFF9DCEFF),
                                    Color(0xFF92A3FD)
                                  ],
                                ).createShader(rect),
                                child: Icon(
                                  Icons.notifications_none_outlined,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Notification",
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
                        Container(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (rect) => LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF9DCEFF),
                                    Color(0xFF92A3FD)
                                  ],
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
                                  colors: [
                                    Color(0xFF9DCEFF),
                                    Color(0xFF92A3FD)
                                  ],
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
                                  colors: [
                                    Color(0xFF9DCEFF),
                                    Color(0xFF92A3FD)
                                  ],
                                ).createShader(rect),
                                child: Icon(
                                  Icons.logout,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Log out",
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
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Log Out"),
                                          content: const Text(
                                              "Are you sure want to log out?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                SharedPreferences.getInstance()
                                                    .then((value) =>
                                                        value.clear());
                                                Navigator.pop(context);
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        "/auth",
                                                        (route) => false);
                                              },
                                              child: const Text("Log Out"),
                                            ),
                                          ],
                                        );
                                      });
                                },
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
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
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
      ProfileController.updatePhoto(int.parse(dataUser["uid"]), selectedimage!);
      User userId =
          await profileController.findById(int.parse(dataUser["uid"]));
      setState(() {
        print(userId.photoUrl!);
        SharedPref.saveStr('photoURL', userId.photoUrl!);
        dataUser['photoURL'] = userId.photoUrl!;
      });

      Navigator.of(context).pop();
    } catch (e) {
      print("Error selecting image: $e");
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
      ProfileController.updatePhoto(int.parse(dataUser["uid"]), selectedimage!);
      User userId =
          await profileController.findById(int.parse(dataUser["uid"]));
      setState(() {
        print(userId.photoUrl!);
        SharedPref.saveStr('photoURL', userId.photoUrl!);
        dataUser['photoURL'] = userId.photoUrl!;
      });

      Navigator.of(context).pop();
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
                      // _pickImage(ImageSource.camera);
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
                      // _pickImage(ImageSource.gallery);
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
