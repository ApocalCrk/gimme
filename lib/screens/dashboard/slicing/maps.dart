import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);
  
  @override
  // ignore: library_private_types_in_public_api
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final String overpassUrl = "https://overpass-api.de/api/interpreter";
  Position? _currentPosition;
  final MapController _mapController = MapController();
  List<Map<String, dynamic>> gyms = [];
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _getLocation();
  }

  @override
  void dispose() {
    _isMounted = false;
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await getCurrentLocation();
      if (_isMounted) {
        setState(() {
          _currentPosition = position;
          getNearbyGyms(position.latitude, position.longitude);
        });
      }
    }
  }

  Future<Position> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      return Position(latitude: -7.7796, longitude: 110.4146, accuracy: 0.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0, timestamp: DateTime.now(), floor: 0, altitudeAccuracy: 0.0, headingAccuracy: 0.0);
    }
  }

  Future<void> getNearbyGyms(double lat, double long) async {
    String overpassQuery = """
      [out:json];
      (
        node["leisure"="fitness_centre"](around:1000,$lat,$long);
        node["amenity"="gym"](around:1000,$lat,$long);
        way["leisure"="fitness_centre"](around:1000,$lat,$long);
        relation["leisure"="fitness_centre"](around:1000,$lat,$long);
      );
      out center;
    """;
    http.Response response = await http.get(Uri.parse('$overpassUrl?data=${Uri.encodeQueryComponent(overpassQuery)}'));
    Map<String, dynamic> data = json.decode(response.body);
    List<Map<String, dynamic>> newGyms = [];
    for (var element in data['elements']) {
      if(element['tags']['name'] != null){
        Map<String, dynamic> gymInfo = {
          'name': element['tags']['name'] ?? 'N/A',
          'latitude': element['lat'] ?? 'N/A',
          'longitude': element['lon'] ?? 'N/A',
        };
        newGyms.add(gymInfo);
      }
    }
    if(_isMounted){
      setState(() {
        gyms = newGyms;
      });
    }
  }

  _buildMap() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 350.0, 
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _currentPosition != null
              ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
              : const LatLng(0, 0),
          zoom: 15.0,
          maxZoom: 18.0,
          minZoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
            maxZoom: 18,
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 20.0,
                height: 20.0,
                point: _currentPosition != null
                    ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                    : const LatLng(0, 0),
                builder: (ctx) => const Icon(
                  Icons.circle,
                  color: Colors.blue,
                  size: 15,
                ),
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              for (var gym in gyms)
                Marker(
                  width: 20.0,
                  height: 20.0,
                  point: LatLng(gym['latitude'], gym['longitude']),
                  builder: (ctx) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/maps');
                    },
                    child: const Icon(
                      Icons.run_circle,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ),
            ],
          ),
          CircleLayer(
            circles: [
              CircleMarker(
                point: _currentPosition != null
                    ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                    : const LatLng(0, 0),
                color: Colors.blue.withOpacity(0.1),
                borderColor: Colors.blue.withOpacity(0.3),
                borderStrokeWidth: 2,
                radius: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: _currentPosition != null
            ? _buildMap()
            : Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350.0,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}