import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:http/http.dart';

class AddReviewScreen extends StatefulWidget {
  Map<String, dynamic> review;
  AddReviewScreen({Key? key, required this.review}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.review['description'] != null) {
      messageController.text = widget.review['description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
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
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            Text(
              widget.review['description'] != null
                  ? "Edit Review"
                  : "Add Review",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat"),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
      const SizedBox(height: 20),
      const SizedBox(height: 20),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rating",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        for (var i = 0; i < 5; i++)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.review['rating'] = i + 1;
                              });
                            },
                            child: Icon(
                              Icons.star,
                              color: widget.review != null &&
                                      widget.review['rating'] > i
                                  ? Colors.yellow
                                  : Colors.grey,
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Message",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                        maxLines: 5,
                        decoration: const InputDecoration(
                            hintText: "Message",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.black))),
                        controller: messageController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.review['description'] != null
                                ? put(
                                    Uri.http(url,
                                        '$endpoint/gym/review/updateReview'),
                                    body: {
                                        'id_gym':
                                            widget.review['id_gym'].toString(),
                                        'uid': dataUser['uid'].toString(),
                                        'description': messageController.text,
                                        'rating':
                                            widget.review['rating'].toString()
                                      }).then((value) {
                                    Navigator.pushNamed(context, '/gym/reviews',
                                        arguments: widget.review['id_gym']);
                                  })
                                : post(
                                    Uri.http(url,
                                        '$endpoint/gym/review/sendGymReview'),
                                    body: {
                                        'description': messageController.text,
                                        'id_gym':
                                            widget.review['id_gym'].toString(),
                                        'uid': dataUser['uid'].toString(),
                                        'rating':
                                            widget.review['rating'].toString()
                                      }).then((value) {
                                    if (jsonDecode(value.body)['status'] ==
                                        'success') {
                                      Navigator.pushNamed(
                                          context, '/gym/reviews',
                                          arguments: widget.review['id_gym']);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content:Text(
                                            'Kamu sudah memberikan review'),
                                        backgroundColor:Colors.red,
                                      ));
                                    }
                                  });
                          }
                        },
                        child: const Text(
                          "Send",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat"),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ])))
    ])));
  }
}
