// ignore_for_file: file_names

import 'package:gimme/data/detail_gym.dart';
import 'package:gimme/data/Membership.dart';
import 'package:http/http.dart';
import 'package:gimme/constants.dart';
import 'dart:convert';

class ExploreController {
  Future<List<DetailGym>> getNearbyGyms(double lat, double long) async {
    var response = await get(Uri.http(url, '$endpoint/gym/getNearbyGym/$lat/$long'));
    if(response.statusCode != 200) return [];
    var data = json.decode(response.body)['data'];
    List<DetailGym> result = [];
    for (var i = 0; i < data.length; i++) {
      data[i]['facilities'] = json.decode(data[i]['facilities'])['facilities'];
      data[i]['packages'] = json.decode(data[i]['packages'])['package'];
      result.add(DetailGym.fromJson(data[i]));
    }
    return result;
  }

  Future<List<DetailGym>> searchGym(double lat, double long, String query) async {
    var response = await get(Uri.http(url, '$endpoint/gym/searchGymByNearby/$lat/$long/$query'));
    if(response.statusCode != 200) return [];
    var data = json.decode(response.body)['data'];
    List<DetailGym> result = [];
    for (var i = 0; i < data.length; i++) {
      data[i]['facilities'] = json.decode(data[i]['facilities'])['facilities'];
      data[i]['packages'] = json.decode(data[i]['packages'])['package'];
      result.add(DetailGym.fromJson(data[i]));
    }
    return result;
  }

  Future<List<DetailGym>> getTopReviewsGyms(double lat, double long) async {
    var response = await get(Uri.http(url, '$endpoint/gym/getTopReviewsGym/$lat/$long'));
    if(response.statusCode != 200) return [];
    var data = json.decode(response.body)['data'];
    List<DetailGym> result = [];
    for (var i = 0; i < data.length; i++) {
      data[i]['facilities'] = json.decode(data[i]['facilities'])['facilities'];
      data[i]['packages'] = json.decode(data[i]['packages'])['package'];
      result.add(DetailGym.fromJson(data[i]));
    }
    return result;
  }

  Future<List<DetailGym>> getTopRatedGyms(double lat, double long) async {
    var response = await get(Uri.http(url, '$endpoint/gym/getTopGym/$lat/$long'));
    if(response.statusCode != 200) return [];
    var data = json.decode(response.body)['data'];
    List<DetailGym> result = [];
    for (var i = 0; i < data.length; i++) {
      data[i]['facilities'] = json.decode(data[i]['facilities'])['facilities'];
      data[i]['packages'] = json.decode(data[i]['packages'])['package'];
      result.add(DetailGym.fromJson(data[i]));
    }
    return result;
  }

  Future<List<Membership>> countMembership(int id) async {
    var response = await get(Uri.http(url, '$endpoint/gym/countMembership/$id'));
    if(response.statusCode != 200) return [];
    var data = json.decode(response.body)['data'];
    List<Membership> result = [];
    for (var i = 0; i < data.length; i++) {
      result.add(Membership.fromJson(data[i]));
    }
    return result;
  }
}