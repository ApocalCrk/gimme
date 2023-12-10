import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/controller/gymController.dart';
import 'package:gimme/controller/reviewsController.dart';
import 'package:gimme/data/review.dart';
import 'package:gimme/screens/gym/detail_screen.dart';
import 'package:gimme/screens/gym/reviews/slicing/widget.dart';
import 'package:http/http.dart';


class ReviewsScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const ReviewsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<ReviewGym> reviews = [];
  var isMembership = false;

  checkMembership() async {
    var check = await GymController().findMembershipCheck(widget.data['id_gym'], int.parse(dataUser['uid'].toString()));
    if(check != null) {
      setState(() {
        isMembership = true;
      });
    }
  }

  getReviews() async {
    var data = await ReviewsController().getReviews(widget.data['id_gym']);
    setState(() {
      reviews = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getReviews();
    checkMembership();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text(
              "Review Detail",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Montserrat",
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, widget.data['route'], arguments: {
                  'id': widget.data['id_gym'],
                  'route': savedRoute
                });
              },
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
            ),
          ),
          SliverToBoxAdapter(
            child:Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        ReviewsController().getTotalRating(reviews),
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Montserrat",
                          fontSize: 40,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Row(
                        children: getStarRating(reviews),
                      ),
                      Text(
                        "(${reviews.length} reviews)",
                      )
                    ],
                  ),
                  getEachRatingIndicator(context, reviews)
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Rate and Review",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontSize: 24,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Shared your experience to help others",
                style: TextStyle(
                  color: secondaryColor,
                  fontFamily: "Montserrat",
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: secondaryColor,
                    backgroundImage: Image.network(dataUser['photoURL'], gaplessPlayback: true).image,
                    radius: 30,
                  ),
                  const SizedBox(width: 10),
                  reviewStarTap(context, isMembership, widget.data['id_gym'])
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Sort by',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reviews.sort((a, b) => b.rating!.compareTo(a.rating!));
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primary2Color)
                        ),
                        child: const Text(
                          'Highest Rating',
                          style: TextStyle(
                            color: primary2Color,
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reviews.sort((a, b) => b.created_at!.compareTo(a.created_at!));
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primary2Color)
                        ),
                        child: const Text(
                          'Newest',
                          style: TextStyle(
                            color: primary2Color,
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reviews.sort((a, b) => a.created_at!.compareTo(b.created_at!));
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primary2Color)
                        ),
                        child: const Text(
                          'Oldest',
                          style: TextStyle(
                            color: primary2Color,
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reviews.sort((a, b) => a.rating!.compareTo(b.rating!));
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primary2Color)
                        ),
                        child: const Text(
                          'Lowest Rating',
                          style: TextStyle(
                            color: primary2Color,
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: secondaryColor,
                                backgroundImage: Image.network(reviews[index].user!['profilepicture'], gaplessPlayback: true).image,
                                radius: 30,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reviews[index].user!['name'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Montserrat",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Text(
                                    ReviewsController().checkUser(reviews[index].created_at.toString()),
                                    style: TextStyle(
                                      color: secondaryColor.withAlpha(150),
                                      fontFamily: "Montserrat",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          int.parse(dataUser['uid'].toString()) == int.parse(reviews[index].user!['uid'].toString()) ?
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/gym/review', arguments: reviews[index]);
                                },
                                icon: const Icon(Icons.edit_rounded, color: secondaryColor),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Delete Review"),
                                        content: const Text("Are you sure want to delete this review?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              delete(Uri.http(url, '$endpoint/gym/review/deleteReview'), body: {
                                                'id_gym': widget.data['id_gym'].toString(),
                                                'uid': dataUser['uid'].toString(),
                                              }).then((value) {
                                                if (value.statusCode == 200) {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    reviews.removeAt(index);
                                                  });
                                                }
                                              });
                                            },
                                            child: const Text("Delete"),
                                          )
                                        ],
                                      );
                                    }
                                  );
                                },
                                icon: const Icon(Icons.delete_rounded, color: secondaryColor),
                              )
                            ],
                          )
                          :
                          const SizedBox()
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Row(
                            children: ReviewsController().getUserStarRating(reviews[index].rating!),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            formatStringDate(reviews[index].created_at.toString()),
                            style: TextStyle(
                              color: secondaryColor.withAlpha(150),
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        reviews[index].description!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      (reviews[index].images)!.isNotEmpty ?
                      Transform.translate(
                        offset: const Offset(0, -15),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: reviews[index].images!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10
                          ),
                          itemBuilder: (context, index2) {
                            return GestureDetector(
                              onTap: () async {
                                await showDialog(context: context, builder: (_) => popUpImage(context, reviews[index].images![index2]));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: reviews[index].images![index2],
                                    fit: BoxFit.cover,
                                    errorWidget: (context, error, stackTrace) {
                                      return const SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Center(
                                          child: Icon(Icons.error),
                                        ),
                                      );
                                    },
                                    progressIndicatorBuilder: (context, url, downloadProgress) => 
                                      Center(
                                        child: CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                        ),
                                      ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                      :
                      const SizedBox()
                    ],
                  ),
                );
              },
              childCount: reviews.length,
            ),
          ),
        ],
      ),
    );
  }
}