import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gimme/constants.dart';
import 'package:http/http.dart';
import 'package:percent_indicator/percent_indicator.dart';


class ReviewsScreen extends StatefulWidget {
  final int id;
  const ReviewsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<Map<String, dynamic>> reviews = [];

  getReviews() async {
    get(Uri.http(url, '$endpoint/gym/review/getGymReviews/${widget.id}')).then((value) {
      var data = jsonDecode(value.body);
      for (var element in data['data']) {
        setState(() {
          reviews.add(element);
        });
      }
    });
  }

  String getTotalRating() {
    double total = 0;
    for (var element in reviews) {
      total += element['rating'];
    }
    return (total / reviews.length).toStringAsFixed(1);
  }

  double getEachPercent(int rating) {
    double total = 0;
    for (var element in reviews) {
      if (element['rating'] == rating) {
        total += 1;
      }
    }
    return total / reviews.length;
  }

  getUserStarRating(int rating) {
    List<Widget> stars = [];
    for (var i = 0; i < 5; i++) {
      if (i < rating) {
        stars.add(const Icon(Icons.star_rounded, color: Colors.yellow));
      } else {
        stars.add(const Icon(Icons.star_rounded, color: Colors.grey));
      }
    }
    return stars;
  }

  Widget getEachRatingIndicator(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.7,
              lineHeight: 8.0,
              percent: getEachPercent(5),
              backgroundColor: Colors.grey.shade300,
              progressColor: Colors.yellow,
              barRadius: const Radius.circular(10)
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.7,
              lineHeight: 8.0,
              percent: getEachPercent(4),
              backgroundColor: Colors.grey.shade300,
              progressColor: Colors.yellow,
              barRadius: const Radius.circular(10)
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.7,
              lineHeight: 8.0,
              percent: getEachPercent(3),
              backgroundColor: Colors.grey.shade300,
              progressColor: Colors.yellow,
              barRadius: const Radius.circular(10)
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.7,
              lineHeight: 8.0,
              percent: getEachPercent(2),
              backgroundColor: Colors.grey.shade300,
              progressColor: Colors.yellow,
              barRadius: const Radius.circular(10)
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.7,
              lineHeight: 8.0,
              percent: getEachPercent(1),
              backgroundColor: Colors.grey.shade300,
              progressColor: Colors.yellow,
              barRadius: const Radius.circular(10)
            )
          ],
        ),
      ]
    );
  }

  List<Widget> getStarRating() {
    List<Widget> stars = [];
    double total = 0;
    for (var element in reviews) {
      total += element['rating'];
    }
    double rating = total / reviews.length;
    if (rating % 1 == 0) {
      for (var i = 0; i < 5; i++) {
        if (i < rating) {
          stars.add(const Icon(Icons.star_rounded, color: Colors.yellow));
        } else {
          stars.add(const Icon(Icons.star_rounded, color: Colors.grey));
        }
      }
    }
    return stars;
  }

  int totalReview() {
    return reviews.length;
  }
  
  Widget reviewStarTap(){
    return Row(
      children: [
        InkWell(onTap: () {
          Navigator.pushNamed(context, '/gym/review', arguments: {'id_gym': widget.id, 'rating': 1});
        }, child: SvgPicture.asset("assets/images/icon/star.svg", width: 55, height: 55)),
        InkWell(onTap: () {
          Navigator.pushNamed(context, '/gym/review', arguments: {'id_gym': widget.id, 'rating': 2});
        }, child: SvgPicture.asset("assets/images/icon/star.svg", width: 55, height: 55)),
        InkWell(onTap: () {
          Navigator.pushNamed(context, '/gym/review', arguments: {'id_gym': widget.id, 'rating': 3});
        }, child: SvgPicture.asset("assets/images/icon/star.svg", width: 55, height: 55)),
        InkWell(onTap: () {
          Navigator.pushNamed(context, '/gym/review', arguments: {'id_gym': widget.id, 'rating': 4});
        }, child: SvgPicture.asset("assets/images/icon/star.svg", width: 55, height: 55)),
        InkWell(onTap: () {
          Navigator.pushNamed(context, '/gym/review', arguments: {'id_gym': widget.id, 'rating': 5});
        }, child: SvgPicture.asset("assets/images/icon/star.svg", width: 55, height: 55)),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
    getReviews();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 50,
                  height: 50,
                  child: Center(
                    child: IconButton(
                      onPressed: () async{
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                  ),
                ),
                const Text(
                  "Review Detail",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 24,
                    fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
            sizedBoxDefault,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      getTotalRating(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontSize: 40,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Row(
                      children: getStarRating(),
                    ),
                    Text(
                      "(${totalReview()})",
                    )
                  ],
                ),
                getEachRatingIndicator()
              ],
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rate and Review",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 24,
                    fontWeight: FontWeight.w600
                  ),
                ),
                const Text(
                  "Shared your experience to help others",
                  style: TextStyle(
                    color: secondaryColor,
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: secondaryColor,
                      backgroundImage: Image.memory(base64Decode(dataUser['photoURL']), gaplessPlayback: true).image,
                      radius: 30,
                    ),
                    const SizedBox(width: 10),
                    reviewStarTap()
                  ],
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reviews[index]['user']['name'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Montserrat",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    Row(
                                      children: getUserStarRating(reviews[index]['rating']),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              reviews[index]['rating'].toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Montserrat",
                                fontSize: 40,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        sizedBoxDefault,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              reviews[index]['description'],
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            reviews[index]['uid'].toString() != dataUser['uid'].toString() ? const SizedBox()
                            :
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/gym/review', arguments: reviews[index]);
                                  },
                                  icon: const Icon(Icons.edit_rounded),
                                ),
                                IconButton(
                                  onPressed: () {
                                    delete(Uri.http(url, '$endpoint/gym/review/deleteReview', {'id_gym': reviews[index]['id_gym'].toString(), 'uid': dataUser['uid']})).then((value) {
                                      if (value.statusCode == 200) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Review has been deleted"),
                                            backgroundColor: successColor,
                                          )
                                        );
                                        setState(() {
                                          reviews.removeAt(index);
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Failed to delete review"),
                                            backgroundColor: errorColor,
                                          )
                                        );
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.delete_rounded),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              ),
            )
          ],
        ),
      )
    );
  }
}