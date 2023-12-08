// ignore_for_file: use_build_context_synchronously, file_names, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/data/review.dart';
import 'package:http/http.dart';

class ReviewController {
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final ReviewGym review;
  final TextEditingController messageController;
  List<dynamic> files;
  final String url;
  final String endpoint;

  ReviewController({
    required this.context,
    required this.formKey,
    required this.review,
    required this.messageController,
    required this.files,
    required this.url,
    required this.endpoint,
  });

  Future<void> submitReview() async {
    if (formKey.currentState!.validate()) {
      if (review.id_review != null) {
        await _updateReview();
      } else {
        await _sendGymReview();
      }
    }
  }

  Future<void> _updateReview() async {
    var response = await put(Uri.http(url, '$endpoint/gym/review/updateReview'), body: {
      'id_gym': review.id_gym.toString(),
      'uid': review.uid.toString(),
      'description': messageController.text,
      'rating': review.rating.toString(),
    });

    if (response.statusCode == 200) {
      var request = MultipartRequest('POST', Uri.http(url, '$endpoint/gym/review/uploadImage'));
      request.fields['id_gym'] = review.id_gym.toString();
      request.fields['uid'] = review.uid.toString();
      for(var images in files){
        request.files.add(await MultipartFile.fromPath('images[]', images.path));
      }
      var decodedResponse = jsonDecode(response.body);
      request.send().then((_) {
        if (decodedResponse['status'] == 'success') {
          Navigator.pushNamed(context, '/gym/reviews', arguments: {'id_gym': review.id_gym, 'route': '/gym/detail'});
        }
      });
    }else{
      Navigator.pushNamed(context, '/gym/reviews', arguments: {'id_gym': review.id_gym, 'route': '/gym/detail'});
    }
  }

  Future<void> _sendGymReview() async {
    var response = await post(Uri.http(url, '$endpoint/gym/review/sendGymReview'), body: {
      'id_gym': review.id_gym.toString(),
      'uid': dataUser['uid'].toString(),
      'description': messageController.text,
      'rating': review.rating.toString(),
    });
          print(response.statusCode);
    if (response.statusCode == 200) {
      var request = MultipartRequest('POST', Uri.http(url, '$endpoint/gym/review/uploadImage'));
      request.fields['id_gym'] = review.id_gym.toString();
      request.fields['uid'] = dataUser['uid'].toString();
      for(var images in files){
        request.files.add(await MultipartFile.fromPath('images[]', images.path));
      }
      var decodedResponse = jsonDecode(response.body);
      request.send().then((_) {
        if (decodedResponse['status'] == 'success') {
          Navigator.pushNamed(context, '/gym/reviews', arguments: {'id_gym': review.id_gym, 'route': '/gym/detail'});
        }
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have already given a review'),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.pushNamed(context, '/gym/reviews', arguments: {'id_gym': review.id_gym, 'route': '/gym/detail'});
    }
  }
}