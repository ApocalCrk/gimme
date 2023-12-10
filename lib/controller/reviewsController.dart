// ignore_for_file: non_constant_identifier_names, file_names
import 'dart:convert';
import 'package:gimme/constants.dart';
import 'package:gimme/data/review.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class ReviewsController {
  Future<List<ReviewGym>> getReviews(int id_gym) async {
    try {
      return await get(Uri.http(url, '$endpoint/gym/review/getGymReviews/$id_gym')).then((value) {
        var data = jsonDecode(value.body);
        if (data['data'] != null) {
          List<ReviewGym> reviews = [];
          for (var i = 0; i < data['data'].length; i++) {
            reviews.add(ReviewGym.fromJson(data['data'][i]));
          }
          return reviews;
        } else {
          return [];
        }
      });
    } catch (e) {
      return [];
    }
  }

  double getEachPercent(int rating, List<ReviewGym> reviews) {
    double total = 0;
    for (var element in reviews) {
      if (element.rating == rating) {
        total += 1;
      }
    }
    if(total == 0){
      return 0;
    }
    return total / reviews.length;
  }

  String getTotalRating(List<ReviewGym> reviews) {
    double total = 0;
    int validRatingsCount = 0;
    for (var element in reviews) {
      if (element.rating != 0) {
        total += element.rating!;
        validRatingsCount += 1;
      }
    }
    if (validRatingsCount == 0) {
      return "0.0";
    }
    return (total / validRatingsCount).toStringAsFixed(1);
  }

  getUserStarRating(int rating) {
    List<Widget> stars = [];
    for (var i = 0; i < 5; i++) {
      if (i < rating) {
        stars.add(const Icon(Icons.star_rounded, color: Colors.yellow, size: 30));
      } else {
        stars.add(const Icon(Icons.star_rounded, color: Colors.grey, size: 30));
      }
    }
    return stars;
  }

  String checkUser(String date) {
    var dateSplit = date.split("T");
    var dateSplit2 = dateSplit[0].split("-");
    DateTime now = DateTime.now();
    DateTime newDate = DateTime(int.parse(dateSplit2[0]), int.parse(dateSplit2[1]), int.parse(dateSplit2[2].split(" ")[0]));
    var difference = now.difference(newDate).inDays;
    if (difference > 330) {
      return "Professional User";
    } else {
      return "New User";
    }
  }

}