// ignore_for_file: file_names, non_constant_identifier_names

class CacheNearbyGymModel {
  int? id_gym;
  String? name;
  double? latitude;
  double? longitude;
  String? place;
  String? description;
  String? open_close_time;
  Map<String, dynamic>? facilities;
  String? image;
  Map<String, dynamic>? packages;
  List<dynamic>? gymreviews;
  List<dynamic>? pickImages;

  CacheNearbyGymModel({
    this.id_gym,
    this.name,
    this.latitude,
    this.longitude,
    this.place,
    this.description,
    this.open_close_time,
    this.facilities,
    this.image,
    this.packages,
    this.gymreviews,
    this.pickImages
  });

  factory CacheNearbyGymModel.fromJson(Map<String, dynamic> json) {
    return CacheNearbyGymModel(
      id_gym: json['id_gym'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      place: json['place'],
      description: json['description'],
      open_close_time: json['open_close_time'],
      facilities: json['facilities'],
      image: json['image'],
      packages: json['packages'],
      gymreviews: json['gymreviews'],
      pickImages: json['pickImages']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_gym': id_gym.toString(),
      'name': name.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'place': place.toString(),
      'description': description.toString(),
      'facilities': facilities.toString(),
      'open_close_time': open_close_time.toString(),
      'image': image.toString(),
      'packages': packages.toString(),
      'gymreviews': gymreviews.toString(),
      'pickImages': pickImages.toString()
    };
  }

}
