// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/controller/mapsController.dart';
import 'package:gimme/data/cacheNearbyModel.dart';
import 'package:gimme/screens/gym/detail_screen.dart';
import 'package:latlong2/latlong.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:extended_image/extended_image.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> with TickerProviderStateMixin {
  Position? _currentPosition;
  String? city, location;
  late MapController _mapController;
  double getCurrentBtnLocation = 100;
  double defaultSlideUpPanelHeight = 80;
  double defaultSlideUpPanelHeightMax = 130;
  double radiusUser = 1000;
  List<CacheNearbyGymModel> gyms = [];
  CacheNearbyGymModel selectedGym = CacheNearbyGymModel();
  bool onSelectedGym = false;
  PanelController panelController = PanelController();
  late bool coordinateCheck;
  bool hiddenSearchMyLocation = false, gymRegistered = false;

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

  Future<String> getPlace(double lat, double long){
    return MapsController().getPlace(lat, long).then((value) {
      setState(() {
        city = MapsController().removeSuffix(value.locality.toString());
        location = "${value.subLocality == "" ?  "Unknown Local" : value.subLocality}, ${value.subAdministrativeArea}";
      });
      return "${value.locality == "" ?  "Unknown City" : value.locality}, ${value.subAdministrativeArea}";
    });
  }

  Future<Position> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        coordinateCheck = true;
        getPlace(_currentPosition!.latitude, _currentPosition!.longitude);
        getNearbyGyms(radiusUser, _currentPosition!.latitude, _currentPosition!.longitude);
      });
      return position;
    } catch (e) {
      return Position(latitude: -7.7796, longitude: 110.4146, accuracy: 0.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0, timestamp: DateTime.now(), floor: 0, altitudeAccuracy: 0.0, headingAccuracy: 0.0);
    }
  }

  Future<void> getNearbyGyms(double radiusUser, double lat, double long) async {
    MapsController().getNearbyGyms(radiusUser, lat, long).then((value) {
      setState(() {
        gyms = value;
      });
    });
  }

  String getTotalRating() {
    double total = 0;
    int validRatingsCount = 0;
    for (var element in selectedGym.gymreviews ?? []) {
      if (element.containsKey('rating') && element['rating'] is num) {
        total += element['rating'];
        validRatingsCount++;
      }
    }
    if (validRatingsCount == 0) {
      return "0.0";
    }
    return (total / validRatingsCount).toStringAsFixed(1);
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
                  selectedGym = CacheNearbyGymModel();
                  defaultSlideUpPanelHeight = 80;
                  defaultSlideUpPanelHeightMax = 130;
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
                      point: LatLng((gym.latitude)!, (gym.longitude)!),
                      builder: (ctx) => GestureDetector(
                        onTap: () async {
                          _animatedMapMove(
                            LatLng((gym.latitude)!, (gym.longitude)!)
                          );
                          var getPlaceDetail = await getPlace((gym.latitude)!, (gym.longitude)!);
                          MapsController().getGymDetail(gym.latitude!, gym.longitude!).then((value) {
                            if(value.id_gym != null){
                              setState(() {
                                selectedGym = value;
                                onSelectedGym = true;
                                defaultSlideUpPanelHeight = 130;
                                defaultSlideUpPanelHeightMax = 350;
                                hiddenSearchMyLocation = true;
                                gymRegistered = true;
                                panelController.open();
                              });
                            }else{
                              setState(() {
                                onSelectedGym = true;
                                gym.place = getPlaceDetail;
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
                        Navigator.popAndPushNamed(context, '/dashboard', arguments: 0);
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
                          child: ExtendedImage.network(
                            selectedGym.image!,
                            fit: BoxFit.cover,
                            cache: true,
                            borderRadius: BorderRadius.circular(50),
                            shape: BoxShape.rectangle,
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                    ),
                                  );
                                case LoadState.completed:
                                  return ExtendedRawImage(
                                    image: state.extendedImageInfo?.image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  );
                                case LoadState.failed:
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                default:
                                  return const SizedBox();
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${selectedGym.name}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${selectedGym.place}",
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
                              Text(
                                getTotalRating(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                child: const Text(
                                  "View reviews",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/gym/reviews', arguments: {'id_gym': selectedGym.id_gym, 'route': '/maps'});
                                },
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
                            child:
                            selectedGym.pickImages!.isNotEmpty ?
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedGym.pickImages!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    await showDialog(context: context, builder: (_) => popUpImage(context, selectedGym.pickImages![index]));
                                  },
                                  child: ExtendedImage.network(
                                    selectedGym.pickImages![index],
                                    fit: BoxFit.cover,
                                    cache: true,
                                    borderRadius: BorderRadius.circular(5),
                                    shape: BoxShape.rectangle,
                                    loadStateChanged: (ExtendedImageState state) {
                                      switch (state.extendedImageLoadState) {
                                        case LoadState.loading:
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        case LoadState.completed:
                                          return Container(
                                            margin: const EdgeInsets.only(right: 20),
                                            child: ExtendedRawImage(
                                              image: state.extendedImageInfo?.image,
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        case LoadState.failed:
                                          return GestureDetector(
                                            onTap: () async {
                                              await showDialog(context: context, builder: (_) => popUpImage(context, selectedGym.pickImages![index]));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width - 40,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.error,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        default:
                                          return const SizedBox();
                                      }
                                    },
                                  ),
                                );
                              },
                            )
                            :
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Center(
                                child: Text(
                                  "No Images",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() { 
                        savedRoute = '/maps';
                      });
                      Navigator.pushNamed(context, '/gym/detail', arguments: {'id': selectedGym.id_gym, 'route': '/maps'}); 
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
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
                    "${selectedGym.name}",
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
                    "${selectedGym.place}",
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            radiusUser = 1000;
                          });
                          getNearbyGyms(radiusUser, _currentPosition!.latitude, _currentPosition!.longitude);
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            radiusUser = 2000;
                          });
                          getNearbyGyms(radiusUser, _currentPosition!.latitude, _currentPosition!.longitude);
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