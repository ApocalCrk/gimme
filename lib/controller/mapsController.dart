// ignore_for_file: file_names
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/data/cacheNearbyModel.dart';
import 'package:http/http.dart';

class MapsController {
  final String overpassUrl = "https://overpass-api.de/api/interpreter";
  Future<CacheNearbyGymModel> getGymDetail(double lat, double long) async {
    try {
      var response = get(Uri.http(url, '$endpoint/gym/getMapsDetailGym/$lat/$long'));
      return response.then((value) {
        if(value.statusCode != 200) return CacheNearbyGymModel();
        var data = json.decode(value.body)['data']; 
        data['facilities'] = json.decode(data['facilities'])['facilities'];
        data['packages'] = json.decode(data['packages'])['packages'];
        return CacheNearbyGymModel.fromJson(data);
      });
    } catch (e) {
      return CacheNearbyGymModel();
    }
  }

  removeSuffix(String city) {
    var suffix = ["Kecamatan", "Kabupaten", "Kota", "Provinsi"];
    for (var i = 0; i < suffix.length; i++) {
      if (city.contains(suffix[i])) {
        city = city.replaceAll(suffix[i], "").trim();
      }
    }
    return city;
  }

  Future<Placemark> getPlace(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        return placemarks[0];
      } else {
        return Placemark();
      }
    } catch (e) {
      return Placemark();
    }
  }

  Future<List<CacheNearbyGymModel>> getNearbyGyms(double radiusUser, double lat, double long) async {
    String overpassQuery = """
      [out:json];
      (
        node["leisure"="fitness_centre"](around:$radiusUser,$lat,$long);
        node["amenity"="gym"](around:$radiusUser,$lat,$long);
        way["leisure"="fitness_centre"](around:$radiusUser,$lat,$long);
        relation["leisure"="fitness_centre"](around:$radiusUser,$lat,$long);
      );
      out center;
    """;
    Response response = await get(Uri.parse('$overpassUrl?data=${Uri.encodeQueryComponent(overpassQuery)}'));
    Map<String, dynamic> data = json.decode(response.body);
    List<CacheNearbyGymModel> newGyms = [];
    for (var element in data['elements']) {
      if(element['tags']['name'] != null){
        CacheNearbyGymModel gymInfo = CacheNearbyGymModel(
          name: element['tags']['name'],
          latitude: element['lat'],
          longitude: element['lon']
        );
        newGyms.add(gymInfo);
      }
    }

    return newGyms;
  }

  Future<Position> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      return Position(latitude: -7.7796, longitude: 110.4146, accuracy: 0.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0, timestamp: DateTime.now(), floor: 0, altitudeAccuracy: 0.0, headingAccuracy: 0.0);
    }
  }
}