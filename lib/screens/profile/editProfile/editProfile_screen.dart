// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  File? _selectedimage;
  String? _selectedImageBase64;

  @override
  void initState() {
    super.initState();
    _nameController.text = dataUser['name'];
    _emailController.text = dataUser['email'];
    _dateController.text = dataUser['dateofbirth'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_back_rounded,
                                      color: secondaryColor, size: 30),
                                  onTap: () => Navigator.pop(context),
                                ),
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 25,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox()
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => showImagePickerOption(context),
                                  child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          NetworkImage(dataUser['photoURL'])),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400),
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Masukkan name Anda",
                                  prefixIcon: Icon(Icons.person,
                                      color: Color(0xFF707070)),
                                  labelStyle: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 15,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600),
                                  hintStyle: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 15,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400),
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Masukkan Email Anda",
                                  prefixIcon: Icon(Icons.email,
                                      color: Color(0xFF707070)),
                                  labelStyle: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 15,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600),
                                  hintStyle: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 15,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primaryColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                                onPressed: () {
                                  Map<String, String> body = {
                                    "username": dataUser['username'],
                                    "phone_number": dataUser['phoneNumber'],
                                    "address": dataUser['address'],
                                    "height": dataUser['height'],
                                    "weight": dataUser['weight'],
                                    "dateofbirth": dataUser['dateofbirth'],
                                    "name": _nameController.text,
                                    "email": _emailController.text,
                                    "profilepicture": _selectedImageBase64!,
                                  };
                                  put(
                                          Uri.http(
                                              url, "$endpoint/user/updateUser"),
                                          body: body)
                                      .then((value) {
                                    if (value.statusCode == 200) {
                                      SharedPref.saveStr(
                                          'name', _nameController.text);
                                      SharedPref.saveStr(
                                          'email', _emailController.text);
                                      SharedPref.saveStr(
                                          'photoURL', _selectedImageBase64!);
                                      dataUser['name'] = _nameController.text;
                                      dataUser['email'] = _emailController.text;
                                      dataUser['photoURL'] =
                                          _selectedImageBase64 ?? "";
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Data updated successfully"),
                                        backgroundColor: Colors.green,
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Failed to update data"),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  });
                                },
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Montserrat",
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ]),
                    ]))));
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
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
                    _fromCamera();
                    // _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Gallery"),
                  onTap: () {
                    _fromGalery();
                    // _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _fromGalery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _selectedimage = File(image.path);
    });
    Navigator.of(context).pop();
  }

  Future _fromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      _selectedimage = File(image.path);
    });
    Navigator.of(context).pop();
  }
}
