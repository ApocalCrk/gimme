import 'dart:ui';
import 'package:gimme/constants.dart';
import 'package:gimme/controller/gymController.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gimme/data/detail_gym.dart';

String savedRoute = '/dashboard';

class GymDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  const GymDetailScreen({Key? key, this.data}) : super(key: key);

  @override
  State<GymDetailScreen> createState() => _GymDetailScreenState();
}

class _GymDetailScreenState extends State<GymDetailScreen> {
  DetailGym? tempGym;
  DetailGym? gym;
  int _currentCarousel = 1;
  double defaultContextSizeCut = 2.5;
  final CarouselController _controllerCarousel = CarouselController();
  final ScrollController _scrollController = ScrollController();
  bool isMembership = false;

  Widget buildIndicator(int index) {
    return GestureDetector(
      onTap: () => _controllerCarousel.animateToPage(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _currentCarousel == index ? 30 : 10,
        height: 10,
        decoration: BoxDecoration(
          color: _currentCarousel == index ? primary2Color : lowSecondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
      ),
    );
  }

  checkMembership() async {
    var check = await GymController().findMembershipCheck(widget.data!['id'], int.parse(dataUser['uid'].toString()));
    if(check != null) {
      setState(() {
        isMembership = true;
      });
    }
  }

  String getTotalRating() {
    double total = 0;
    int validRatingsCount = 0;
    for (var element in gym!.gymreviews){
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

  Future<void> getDetailGym(int id) async {
    GymController().getDetailGymId(id).then((value) {
      setState(() {
        gym = value;
      });
    });
  }

  void _scrollListener() {
    setState(() {
      if (_scrollController.offset <= 0) {
        defaultContextSizeCut = 2.5;
      } else if (_scrollController.offset > 0 && _scrollController.offset < 100) {
        defaultContextSizeCut = 2.5 + (_scrollController.offset / 80);
      } 
    });
  }

  @override
  void initState() {
    super.initState();
    getDetailGym(widget.data!['id']);
    _scrollController.addListener(_scrollListener);
    checkMembership();
    widget.data!['route'] == '/dashboard' ? savedRoute = '/dashboard' : savedRoute = '/maps';
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: gym == null ? 
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: MediaQuery.of(context).size.height / defaultContextSizeCut,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                )
                :
                Image.network(
                  gym!.image,
                  height: MediaQuery.of(context).size.height / defaultContextSizeCut,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.8),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Row(
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
                            savedRoute == '/dashboard' ?
                            Navigator.pushNamed(context, savedRoute, arguments: 3)
                            :
                            Navigator.pushNamed(context, savedRoute);
                          },
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                      ),
                    ),
                    const Text(
                      "Gym Detail",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontSize: 24,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / defaultContextSizeCut - 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            gym == null ?
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 100,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                            :
                            Text(
                              gym!.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontSize: 24,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            const SizedBox(height: 10),
                            gym == null ?
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 100,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                            :
                            Text(
                              gym!.place,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.transparent, 
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: 
                          gym == null ?
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )
                          :
                          GestureDetector(
                            onTap:() {
                              Navigator.pushNamed(context, '/gym/reviews', arguments: {
                                'id_gym': gym!.id_gym, 'route': '/gym/detail'
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey.withOpacity(0.5),
                                  child: Text(
                                    getTotalRating(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Montserrat",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ]
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Description",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        gym == null ?
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 50,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                        :
                        Text(
                          "(${gym!.open_close_time})",
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Row(
                      children: [
                        gym == null ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 100,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 150,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 120,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                )
                              ),
                            ),
                            const SizedBox(height: 10),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 140,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                )
                              ),
                            ),
                            const SizedBox(height: 10),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 180,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                )
                              ),
                            ),
                          ],
                        )
                        :
                        Expanded(
                          child: Text(
                            gym!.description,
                            style: const TextStyle(
                              color: secondaryColor,
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Facilities",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        gym == null ?
                        Container(
                          transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        :
                        Container(
                          transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: gym!.facilities.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.transparent, 
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(gym!.facilities[index.toString()]['icon'] ?? "", style: const TextStyle(fontSize: 30)),
                                    const SizedBox(height: 10),
                                    Text(
                                      gym!.facilities[index.toString()]['fac'] ?? '',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Montserrat",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Member Packages",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        isMembership ?
                        const Text(
                          "You have a membership!",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: "Montserrat",
                            fontSize: 12,
                            fontWeight: FontWeight.w600
                          ),
                        )
                        :
                        const SizedBox()
                      ],
                    ),
                  ),
                  gym == null ?
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      width: MediaQuery.of(context).size.width - 40,
                      height: 400,
                      color: Colors.white,
                    ),
                  )
                  :
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CarouselSlider(
                      carouselController: _controllerCarousel,
                      options: CarouselOptions(
                        height: 400.0, 
                        autoPlay: false, 
                        enlargeCenterPage: true, 
                        viewportFraction: 0.7, 
                        initialPage: 1, 
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentCarousel = index;
                          });
                        },
                      ),
                      items: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade400,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.transparent, 
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                            ),
                            _currentCarousel == 0 ?
                            SingleChildScrollView(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 100,
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Image.asset("assets/images/icon/medal-silver.png", width: 100, height: 100),
                                    const Text(
                                      "Silver",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontSize: 26,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    const Text(
                                      "Membership!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                      child: Column(
                                        children: [
                                          for(var items in gym!.packages['Silver']['feature'].entries)
                                            Row(
                                              children: [
                                                const Icon(Icons.check, color: Colors.white, size: 20),
                                                const SizedBox(width: 5),
                                                Text(
                                                  items.value,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Rp. ${moneyFormat(int.parse(gym!.packages['Silver']['price']['monthly']))},00",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                          isMembership ?
                                          const SizedBox()
                                          :
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0)
                                                )
                                              )
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/gym/checkout', arguments: {
                                                'id_gym': gym!.id_gym,
                                                'bundle': 'Silver Membership',
                                                'name': gym!.name,
                                                'place': gym!.place,
                                                'price': gym!.packages['Silver']['price']['monthly'],
                                                'type': 'Membership',
                                                'duration': '1 Month Membership'
                                              });
                                            },
                                            child: const Text(
                                              "Buy Now",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    isMembership ?
                                    const SizedBox(height: 20)
                                    :
                                    const SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Rp. ${moneyFormat(int.parse(gym!.packages['Silver']['price']['yearly']))},00",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                          isMembership ?
                                          const SizedBox()
                                          :
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFF9DA75)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0)
                                                )
                                              )
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/gym/checkout', arguments: {
                                                'id_gym': gym!.id_gym,
                                                'bundle': 'Silver Membership',
                                                'name': gym!.name,
                                                'place': gym!.place,
                                                'price': gym!.packages['Silver']['price']['yearly'],
                                                'type': 'Membership',
                                                'duration': '1 Year Membership'
                                              });
                                            },
                                            child: const Text(
                                              "Buy Now",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            )
                            :
                            const SizedBox()
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: BoxDecoration(
                                color: primary2Color,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.transparent, 
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 100,
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Image.asset("assets/images/icon/medal-gold.png", width: 100, height: 100),
                                    const Text(
                                      "Gold",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontSize: 26,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    const Text(
                                      "Membership!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                      child: Column(
                                        children: [
                                          for(var items in gym!.packages['Gold']['feature'].entries)
                                            Row(
                                              children: [
                                                const Icon(Icons.check, color: Colors.white, size: 20),
                                                const SizedBox(width: 5),
                                                Text(
                                                  items.value,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                    isMembership ?
                                    const SizedBox(height: 20)
                                    :
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Rp. ${moneyFormat(int.parse(gym!.packages['Gold']['price']['monthly']))},00",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                          isMembership ?
                                          const SizedBox()
                                          :
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0)
                                                )
                                              )
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/gym/checkout', arguments: {
                                                'id_gym': gym!.id_gym,
                                                'bundle': 'Gold Membership',
                                                'name': gym!.name,
                                                'place': gym!.place,
                                                'price': gym!.packages['Gold']['price']['monthly'],
                                                'type': 'Membership',
                                                'duration': '1 Month Membership'
                                              });
                                            },
                                            child: const Text(
                                              "Buy Now",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    isMembership ?
                                    const SizedBox(height: 20)
                                    :
                                    const SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Rp. ${moneyFormat(int.parse(gym!.packages['Gold']['price']['yearly']))},00",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                          isMembership ?
                                          const SizedBox()
                                          :
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFF9DA75)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0)
                                                )
                                              )
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/gym/checkout', arguments: {
                                                'id_gym': gym!.id_gym,
                                                'bundle': 'Gold Membership',
                                                'name': gym!.name,
                                                'place': gym!.place,
                                                'price': gym!.packages['Gold']['price']['yearly'],
                                                'type': 'Membership',
                                                'duration': '1 Year Membership'
                                              });
                                            },
                                            child: const Text(
                                              "Buy Now",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: BoxDecoration(
                                color: Colors.brown.shade400,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.transparent, 
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                            ),
                            _currentCarousel == 2 ?
                            SingleChildScrollView(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 100,
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Image.asset("assets/images/icon/medal-bronze.png", width: 100, height: 100),
                                    const Text(
                                      "Bronze",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontSize: 26,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    isMembership ?
                                      const SizedBox()
                                      :
                                      const Text(
                                      "Membership!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                      child: Column(
                                        children: [
                                          for(var items in gym!.packages['Bronze']['feature'].entries)
                                            Row(
                                              children: [
                                                const Icon(Icons.check, color: Colors.white, size: 20),
                                                const SizedBox(width: 5),
                                                Text(
                                                  items.value,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                    isMembership ?
                                    const SizedBox(height: 70)
                                    :
                                    const SizedBox(height: 50),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Rp. ${moneyFormat(int.parse(gym!.packages['Bronze']['price']['monthly']))},00",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                          isMembership ?
                                          const SizedBox()
                                          :
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0)
                                                )
                                              )
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/gym/checkout', arguments: {
                                                'id_gym': gym!.id_gym,
                                                'bundle': 'Bronze Membership',
                                                'name': gym!.name,
                                                'place': gym!.place,
                                                'price': gym!.packages['Bronze']['price']['yearly'],
                                                'type': 'Membership',
                                                'duration': '1 Month Membership'
                                              });
                                            },
                                            child: const Text(
                                              "Buy Now",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    isMembership ?
                                    const SizedBox(height: 20)
                                    :
                                    const SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Rp. ${moneyFormat(int.parse(gym!.packages['Bronze']['price']['yearly']))},00",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Montserrat",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                          isMembership ?
                                          const SizedBox()
                                          :
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFF9DA75)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0)
                                                )
                                              )
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/gym/checkout', arguments: {
                                                'id_gym': gym!.id_gym,
                                                'bundle': 'Bronze Membership',
                                                'name': gym!.name,
                                                'place': gym!.place,
                                                'price': gym!.packages['Bronze']['price']['yearly'],
                                                'type': 'Membership',
                                                'duration': '1 Year Membership'
                                              });
                                            },
                                            child: const Text(
                                              "Buy Now",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            )
                            :
                            const SizedBox()
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildIndicator(0),
                      const SizedBox(width: 5),
                      buildIndicator(1),
                      const SizedBox(width: 5),
                      buildIndicator(2),
                    ],
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            )
          )
        ],
      )
    );
  }
}