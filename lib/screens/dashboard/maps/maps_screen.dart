import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/dashboard/maps/controller/mapsController.dart';
import 'package:latlong2/latlong.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> with TickerProviderStateMixin {
  final String overpassUrl = "https://overpass-api.de/api/interpreter";
  Position? _currentPosition;
  String? city, location;
  late MapController _mapController;
  double getCurrentBtnLocation = 100;
  double defaultSlideUpPanelHeight = 80;
  double defaultSlideUpPanelHeightMax = 130;
  double radiusUser = 1000;
  List<Map<String, dynamic>> gyms = [];
  Map<String, dynamic> selectedGym = {};
  Uint8List selectedGymImage = Uint8List(0);
  bool onSelectedGym = false;
  PanelController panelController = PanelController();
  late bool coordinateCheck;
  bool hiddenSearchMyLocation = false, gymRegistered = false;

  Future<String> getPlace(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        final Placemark firstPlacemark = placemarks[0];
        setState(() {
          city = "${firstPlacemark.locality}";
          location = "${firstPlacemark.subLocality == "" ?  "Unknown Local" : firstPlacemark.subLocality}, ${firstPlacemark.subAdministrativeArea}";
        });
        return "${firstPlacemark.locality == "" ?  "Unknown City" : firstPlacemark.locality}, ${firstPlacemark.subAdministrativeArea}";
      } else {
        setState(() {
          location = "Gatau";
        });
        return "Gatau";
      }
    } catch (e) {
      print(e.toString());
      return "Gatau";
    }
  }

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        coordinateCheck = true;
        getPlace(_currentPosition!.latitude, _currentPosition!.longitude);
        getNearbyGyms(_currentPosition!.latitude, _currentPosition!.longitude);
      });
    } catch (e) {
      setState(() {
        _currentPosition = Position(latitude: -7.7796, longitude: 110.4146, accuracy: 0.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0, timestamp: DateTime.now(), floor: 0, altitudeAccuracy: 0.0, headingAccuracy: 0.0);
        print(e.toString());
      });
    }
  }

  Future<void> getNearbyGyms(double lat, double long) async {
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

    setState(() {
      gyms = newGyms;
    });
  }

  void _animatedMapMove(LatLng destLocation) {
    final latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: _mapController.zoom);

    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this); 
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    _mapController = MapController();
    coordinateCheck = false;
  }

  @override
  void dispose() {
    _mapController.dispose();
    getLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentPosition == null ?
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white
              ),
            ),
          )
          :
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentPosition != null
                      ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                      : const LatLng(0, 0),
              onTap: (point, latlng) {
                setState(() {
                  hiddenSearchMyLocation = false;
                  onSelectedGym = false;
                  selectedGym = {};
                  defaultSlideUpPanelHeight = 80;
                  getCurrentBtnLocation = 100;
                  panelController.close();
                });
              },
              onPositionChanged: (position, hasGesture) => {
                setState(() {
                  if(position.center!.latitude != _currentPosition!.latitude && position.center!.longitude != _currentPosition!.longitude){
                    coordinateCheck = false;
                  }else{
                    coordinateCheck = true;
                  }
                })
              },
              zoom: 15.0,
              maxZoom: 18.0,
              minZoom: 10.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
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
                      point: LatLng((gym['latitude']), (gym['longitude'])),
                      builder: (ctx) => InkWell(
                        onTap: () async {
                          _animatedMapMove(
                            LatLng((gym['latitude']), (gym['longitude']))
                          );
                          var getPlaceDetail = await getPlace((gym['latitude']), (gym['longitude']));
                          MapsController().getGymDetail(gym['latitude'], gym['longitude']).then((value) {
                            var data = json.decode(value)['data'];
                            if(data != null){
                              setState(() {
                                selectedGym = data;
                                onSelectedGym = true;
                                defaultSlideUpPanelHeight = 130;
                                defaultSlideUpPanelHeightMax = 350;
                                hiddenSearchMyLocation = true;
                                gymRegistered = true;
                                panelController.open();
                                selectedGymImage = base64Decode(selectedGym['image']);
                              });
                            }else{
                              setState(() {
                                onSelectedGym = true;
                                gym['place'] = getPlaceDetail;
                                selectedGym = gym;
                                defaultSlideUpPanelHeight = 80;
                                defaultSlideUpPanelHeightMax = 130;
                                gymRegistered = false;
                                hiddenSearchMyLocation = true;
                                panelController.close();
                              });
                            }
                          });
                        },
                        child: const Icon(
                          Icons.run_circle_rounded,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 50,
                  height: 50,
                  child: Center(
                    child: IconButton(
                      onPressed: () async{
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                  ),
                ),
                const Text(
                  "Nearby Gyms",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(width: 50, height: 50)
              ],
            ),
          ),
          SlidingUpPanel(
            controller: panelController,
            onPanelSlide: (double pos) {
              if(defaultSlideUpPanelHeightMax != 350){
                setState(() {
                  getCurrentBtnLocation = (pos*50) + 100;
                });
              } else if(pos == 0.0 && onSelectedGym && gymRegistered){
                setState(() {
                  getCurrentBtnLocation = 150;
                });
              } else {
                setState(() {
                  hiddenSearchMyLocation = true;
                });
              }
            },
            onPanelClosed: () {
              setState(() {
                hiddenSearchMyLocation = false;
              });
            },
            minHeight: defaultSlideUpPanelHeight,
            maxHeight: defaultSlideUpPanelHeightMax,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            ),
            panel: onSelectedGym ?
            gymRegistered ?
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(50)
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        child: ClipOval( 
                          child: Image.memory(
                            selectedGymImage,
                            fit: BoxFit.cover,
                            width: 80, 
                            height: 80,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${selectedGym['name']}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${selectedGym['place']}",
                            style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.yellow[700],
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                "4.8",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "View reviews",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 10,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          )
                        ]
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Images",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width - 40,
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 120,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/gym/detail', arguments: selectedGym['id_gym']);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Center(
                            child: Text(
                              "Detail",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            "Book Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
            :
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "${selectedGym['name']}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "${selectedGym['place']}",
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ],
            )
            :  
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: city == null ?
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  )
                  :
                  Text(
                    "Nearby Gym in $city",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: location == null ?
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  )
                  :
                  Text(
                    "$location",
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            radiusUser = 1000;
                          });
                          getNearbyGyms(_currentPosition!.latitude, _currentPosition!.longitude);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Center(
                            child: Text(
                              "1 KM",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            radiusUser = 2000;
                          });
                          getNearbyGyms(_currentPosition!.latitude, _currentPosition!.longitude);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Center(
                            child: Text(
                              "2 KM",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: 
      _currentPosition == null?
      const SizedBox()
      :
      hiddenSearchMyLocation ?
      const SizedBox()
      :
      Padding(
        padding: EdgeInsets.only(bottom: getCurrentBtnLocation),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                _animatedMapMove(
                  LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                );
              },
              backgroundColor: Colors.white,
              child: Icon(
                coordinateCheck ? Icons.my_location :
                Icons.location_searching, 
                color: coordinateCheck ? primary2Color : Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}