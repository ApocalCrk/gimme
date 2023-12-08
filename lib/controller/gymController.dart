// ignore_for_file: file_names

import 'package:http/http.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/data/detail_gym.dart';
import 'dart:convert';

class GymController {
  Future<DetailGym> getDetailGymId(int id) async {
    try{
      var response = get(Uri.http(url, '$endpoint/gym/getDetailGymId/$id'));
      return response.then((value) {
        if(value.statusCode != 200) return throw Exception('Failed to load detail gym');
        var data = json.decode(value.body)['data'];
        data['facilities'] = json.decode(data['facilities'])['facilities'];
        data['packages'] = json.decode(data['packages'])['package'];
        return DetailGym.fromJson(data);
      });
    } catch (e) {
      return throw Exception('Failed to load detail gym');
    }
  }

  findMembershipCheck(int id, int uid) async {
    try {
      var response = get(Uri.http(url, '$endpoint/transaction/findMembershipCheck/$id/$uid'));
      return response.then((value) => jsonDecode(value.body)['data']);
    } catch (e) {
      return throw Exception('Failed to load detail gym');
    }
  }
}