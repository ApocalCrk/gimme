// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gimme/data/review.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:gimme/controller/reviewsController.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget getEachRatingIndicator(BuildContext context, List<ReviewGym> reviews) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.7,
              lineHeight: 8.0,
              percent: ReviewsController().getEachPercent(5, reviews),
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
              percent: ReviewsController().getEachPercent(4, reviews),
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
              percent: ReviewsController().getEachPercent(3, reviews),
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
              percent: ReviewsController().getEachPercent(2, reviews),
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
              percent: ReviewsController().getEachPercent(1, reviews),
              backgroundColor: Colors.grey.shade300,
              progressColor: Colors.yellow,
              barRadius: const Radius.circular(10)
            )
          ],
        ),
      ]
    );
  }

  List<Widget> getStarRating(List<ReviewGym> reviews) {
    List<Widget> stars = [];
    double total = 0;
    for (var element in reviews) {
      total += element.rating!;
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
    } else {
      if (rating.isFinite) {
        for (var i = 0; i < 5; i++) {
          if (i < rating.floor()) {
            stars.add(const Icon(Icons.star_rounded, color: Colors.yellow));
          } else if (i == rating.floor()) {
            stars.add(const Icon(Icons.star_half_rounded, color: Colors.yellow));
          } else {
            stars.add(const Icon(Icons.star_rounded, color: Colors.grey));
          }
        }
      } else {
        for (var i = 0; i < 5; i++) {
          stars.add(const Icon(Icons.star_rounded, color: Colors.grey));
        }
      }
    }
    return stars;
  }

  Widget reviewStarTap(BuildContext context, bool isMembership, int id_gym) {
    return Row(
      children: [
        for (var i = 0; i < 5; i++)
          GestureDetector(onTap: () {
            isMembership ?
            Navigator.pushNamed(context, '/gym/review', arguments: ReviewGym(id_gym: id_gym, rating: i + 1))
            :
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "You can't rating because you don't have a membership",
                ),
                backgroundColor: Colors.red,
              )
            );
          }, child: SvgPicture.asset("assets/images/icon/star.svg", width: 55, height: 55)),
      ],
    );
  }