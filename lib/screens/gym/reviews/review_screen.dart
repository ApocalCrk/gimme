// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/controller/reviewController.dart';
import 'package:gimme/data/review.dart';
import 'package:file_picker/file_picker.dart';

// ignore: must_be_immutable
class ReviewScreen extends StatefulWidget {
  ReviewGym review;
  ReviewScreen({Key? key, required this.review}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<ReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();
  List<dynamic> files = [];
  late ReviewController reviewController;

  @override
  void initState() {
    super.initState();
    if(widget.review.id_review != null){
      messageController.text = widget.review.description!;
    }
    reviewController = ReviewController(
      context: context,
      formKey: _formKey,
      review: widget.review,
      messageController: messageController,
      files: files,
      url: url,
      endpoint: endpoint,
    );
  }

  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(result!.count <= 3 - files.length){
      setState(() {
        if(files.isNotEmpty){
          setState(() { 
            files.addAll(result.paths.map((path) => File(path!)).toList());
            reviewController.files = files;
          });
        }else{
          setState(() {
            files = result.paths.map((path) => File(path!)).toList();
            reviewController.files = files;
          });
        }
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Max 3 files'),
          backgroundColor: Colors.red,
        )
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.review.id_review != null ? "Edit Review" : "Add Review",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            ),
            sizedBoxDefault,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: secondaryColor,
                              backgroundImage: Image.network(dataUser['photoURL']).image,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dataUser['name'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat"
                                  ),
                                ),
                                const Text(
                                  "Posting publicly",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "Montserrat",
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        sizedBoxDefault,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < 5; i++)
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.review.rating = i + 1;
                                      });
                                    },
                                    child: Icon(
                                      Icons.star_rounded,
                                      color: widget.review.rating! > i ? Colors.yellow : Colors.grey,
                                      size: 40,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                          ],
                        ),
                        sizedBoxDefault,
                        const Text(
                          "Share more about your experience",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat"
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: "Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.black)
                            )
                          ),
                          controller: messageController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          }
                        ),
                        const SizedBox(height: 10),
                        files.isNotEmpty ?
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: files[index] is File
                                              ? Image.file(files[index]).image
                                              : NetworkImage(files[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            files.removeAt(index);
                                          });
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.black.withOpacity(0.5),
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ) : const SizedBox(),
                        const SizedBox(height: 10),
                        files.length < 3 ?
                        GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: secondaryColor),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt_rounded, color: secondaryColor),
                                  SizedBox(width: 10),
                                  Text(
                                    "Add Photo",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: secondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () => _pickImage(),
                        ) : const SizedBox(),
                        sizedBoxDefault,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              reviewController.submitReview();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            child: const Text(
                              "Send",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"
                              ),
                            ),
                          ),
                        ),
                      ]
                    )
              )
            ) 

          ]
        )
      )
    );
  }
}