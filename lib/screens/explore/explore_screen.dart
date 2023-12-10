import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/controller/mapsController.dart';
import 'package:gimme/data/detail_gym.dart';
import 'package:gimme/controller/exploreController.dart';
import 'package:gimme/data/Membership.dart';
import 'package:gimme/screens/gym/detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late double lat, long;
  String filter = "Nearby Gym";
  String place = "Loading...";
  bool search = false;
  List<DetailGym> data = [];
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    getLocation();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  getLocation() async {
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (_isMounted) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
      MapsController().getPlace(lat, long).then((value) {
        if(_isMounted){
          setState(() {
            place = value.locality!;
          });
        }
      });
      var result = await ExploreController().getNearbyGyms(lat, long);
      if(_isMounted) {
        setState(() {
          data = result;
        });
      }
    }
  }

  countMembership(int id) async {
    var result = await ExploreController().countMembership(id);
    if(_isMounted) {
      return result;
    }
  }

  String getTotalRating(List<dynamic> reviews) {
    double total = 0;
    int validRatingsCount = 0;
    for (var element in reviews) {
      if (element.containsKey('rating') && element['rating'] is num) {
        total += element['rating'];
        validRatingsCount++;
      }
    }
    if (validRatingsCount == 0) {
      return "0.0";
    }
    return (total / validRatingsCount).toStringAsFixed(1);
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30),
                    Text(
                      "Explore Gyms",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(width: 30)
                  ],
                ),
                sizedBoxDefault,
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: lowSecondaryColor,
                      width: 1
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "My Location",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              place,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.my_location_rounded, color: primary2Color)
                      ]
                    ),
                  ),
                ),
                sizedBoxDefault,
                TextField(
                  onChanged:(value) {
                    if(value.isNotEmpty) {
                      search = true;
                      ExploreController().searchGym(lat, long, value).then((value) {
                      setState(() {
                        data = value;
                      });
                    });
                    } else {
                      search = false;
                      ExploreController().getNearbyGyms(lat, long).then((value) {
                      setState(() {
                        data = value;
                      });
                    });
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: "Search",
                    hintStyle: const TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600
                    ),
                    prefixIcon: const Icon(Icons.search_rounded, color: secondaryColor),
                    suffixIcon: const Icon(Icons.qr_code_scanner_rounded, color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: lowSecondaryColor
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: lowSecondaryColor
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: lowSecondaryColor
                      )
                    )
                  ),
                ),
                search ? const SizedBox(height: 20) :
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      filter,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    DropdownButton<String>(
                      icon: const Text(
                        "Filter",
                        style: TextStyle(
                          color: primary2Color,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600
                      ),
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          filter = newValue!;
                          if(filter == "Popular Nearby Gym") {
                            ExploreController().getTopReviewsGyms(lat, long).then((value) {
                              setState(() {
                                data = value;
                              });
                            });
                          } else if(filter == "Nearby Gym") {
                            ExploreController().getNearbyGyms(lat, long).then((value) {
                              setState(() {
                                data = value;
                              });
                            });
                          } else if(filter == "Top Rated Nearby Gym") {
                            ExploreController().getTopRatedGyms(lat, long).then((value) {
                              setState(() {
                                data = value;
                              });
                            });
                          }
                        });
                      },
                      items: <String>['Popular Nearby Gym', 'Nearby Gym', 'Top Rated Nearby Gym'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: countMembership(data[index].id_gym),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Transform.translate(
                            offset: const Offset(0, -40),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: lowSecondaryColor,
                                    width: 1
                                  )
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.width * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: lowSecondaryColor,
                                          width: 1
                                        ),
                                        color: Colors.grey
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.grey
                                                ),
                                              ),
                                              Container(
                                                width: 50,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.grey
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              )
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return const Text('No membership data available');
                        } else {
                          List<Membership> membership = snapshot.data as List<Membership>;
                          return Transform.translate(
                            offset: const Offset(0, -40),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: lowSecondaryColor,
                                  width: 1
                                )
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: lowSecondaryColor,
                                        width: 1
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(data[index].image),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data[index].name,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.star_rounded, color: Colors.yellow),
                                                const SizedBox(width: 5),
                                                Text(
                                                  getTotalRating(data[index].gymreviews),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.location_on_rounded, color: Colors.grey, size: 12),
                                                Text(
                                                  data[index].place,
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.access_time,
                                                  color: primaryColor,
                                                  size: 12,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  data[index].open_close_time,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          data[index].description,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "People has joined",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                membership.length > 3 ?
                                                Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        for(var i = 0; i < 3; i++)
                                                          membership[i].user.photoUrl == null ?
                                                          Container(
                                                            width: 30,
                                                            height: 30,
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.grey
                                                            ),
                                                          )
                                                          :
                                                          Container(
                                                            margin: EdgeInsets.only(left: i.toDouble() * 15),
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              border: Border.all(
                                                                color: Colors.white,
                                                                width: 2
                                                              )
                                                            ),
                                                            child: CircleAvatar(
                                                              radius: 15,
                                                              backgroundImage: CachedNetworkImageProvider(membership[i].user.photoUrl!),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.only(left: 0),
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 2
                                                        )
                                                      ),
                                                      child: CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor: Colors.grey,
                                                        child: Text(
                                                          "+${membership.length - 3}",
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily: "Montserrat",
                                                            fontWeight: FontWeight.w600
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                                :
                                                Text(
                                                  "${membership.length} people",
                                                  style: const TextStyle(
                                                    color: secondaryColor,
                                                    fontSize: 14,
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                savedRoute = "/dashboard";
                                                Navigator.pushNamed(context, "/gym/detail", arguments: {
                                                  "id": data[index].id_gym,
                                                  "route": "/dashboard"
                                                });
                                              },
                                              child: const Text(
                                                "Detail",
                                                style: TextStyle(
                                                  color: primary2Color,
                                                  fontSize: 12,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w600
                                                ),
                                              )
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ),
                          );
                        }
                      }
                    );
                  }
                )
              
              ]
            )
          ),
        )
      ),
    );
  }
}