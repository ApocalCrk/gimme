import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Position? _currentPosition;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getLocation() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await getCurrentLocation();
      if (position != null) {
        setState(() {
          _currentPosition = position;
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
      print(e.toString());
      return Position(
          latitude: -7.7796,
          longitude: 110.4146,
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          timestamp: DateTime.now(),
          floor: 0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0);
    }
  }

  _buildMap() {
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        double newZoom = _mapController.zoom + details.scale - 1.0;
        if (newZoom >= 1.0 && newZoom <= 18.0) {
          _mapController.move(_mapController.center, newZoom);
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 350.0,
        child: FlutterMap(
          options: MapOptions(
            center: _currentPosition != null
                ? LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude)
                : const LatLng(0, 0),
            zoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            CircleLayer(
              circles: [
                CircleMarker(
                  point: _currentPosition != null
                      ? LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude)
                      : const LatLng(0, 0),
                  color: Colors.blue.withOpacity(0.7),
                  borderColor: Colors.white.withOpacity(0.7),
                  borderStrokeWidth: 2,
                  useRadiusInMeter: true,
                  radius: 20,
                ),
                CircleMarker(
                  point: _currentPosition != null
                      ? LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude)
                      : const LatLng(0, 0),
                  radius: 500,
                  useRadiusInMeter: true,
                  color: Colors.blue.withOpacity(0.2),
                  borderColor: Colors.blue.withOpacity(0.5),
                  borderStrokeWidth: 2,
                ),
              ],
            )
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
