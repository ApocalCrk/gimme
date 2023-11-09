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
  Position? _currentPosition;
  final MapController _mapController = MapController();
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    _getLocation();
    _searchNearbyPlace();
  }

  Future<void> _getLocation() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await getCurrentLocation();
      setState(() {
        _currentPosition = position;
      });
    }
  }

  Future<void> _searchNearbyPlace() async {
    Position position = await getCurrentLocation();
    var dataNearby = await http.get(Uri.parse("https://nominatim.openstreetmap.org/search?q=cafe&format=json&lat=${position.latitude}&lon=${position.longitude}&zoom=18&addressdetails=1"));
    List<dynamic> dataDec = jsonDecode(dataNearby.body);
    setState(() {
      data = dataDec;
    });
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

  _buildMap() {
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        double newZoom = _mapController.zoom + details.scale - 1.0;
        if (newZoom >= 10.0 && newZoom <= 18.0) {
          _mapController.move(_mapController.center, newZoom);
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 350.0, 
        child: FlutterMap(
          options: MapOptions(
            center: _currentPosition != null
                ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                : const LatLng(0, 0),
            zoom: 15.0,
            maxZoom: 18.0,
            minZoom: 10.0,
            // interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
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
            for(var i = 0; i < data.length; i++)
              MarkerLayer(
                markers: [
                  Marker(
                    width: 20.0,
                    height: 20.0,
                    point: LatLng(double.parse(data[i]['lat']), double.parse(data[i]['lon'])),
                    builder: (ctx) => const Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 15,
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