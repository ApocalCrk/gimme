import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';

class Subs extends StatelessWidget {
  const Subs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: const [
          GymCard(
            title: 'Get Membership',
            subtitle: 'Practice Anytime, Anywhere at any Gym',
            backgroundColor: lowPrimary2Color,
            imagePath: "assets/images/icon/gym-tool.png",
            margin: EdgeInsets.only(left: 20),
          ),
          GymCard(
            title: 'Explore Gyms',
            subtitle: 'Discover New Workout Spaces',
            backgroundColor: lowPrimaryColor,
            imagePath: "assets/images/icon/gym-tool.png",
            margin: EdgeInsets.only(left: 20, right: 20),
          ),
        ],
      ),
    );
  }
}

class GymCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final String imagePath;
  final EdgeInsetsGeometry? margin;

  const GymCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.imagePath,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      margin: margin ?? const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
