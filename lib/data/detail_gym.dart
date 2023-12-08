// ignore_for_file: non_constant_identifier_names

class DetailGym {
  final int id_gym;
  final String description, image, name, place, open_close_time;
  final Map<String, dynamic> facilities;
  final Map<String, dynamic> packages;
  final String location;
  final List<dynamic> gymreviews;

  DetailGym({
    required this.description,
    required this.image,
    required this.name,
    required this.place,
    required this.id_gym,
    required this.facilities,
    required this.packages,
    required this.location,
    required this.gymreviews,
    required this.open_close_time
  });

  factory DetailGym.fromJson(Map<String, dynamic> json) {
    return DetailGym(
      description: json['description'],
      image: json['image'],
      name: json['name'],
      place: json['place'],
      id_gym: json['id_gym'],
      facilities: json['facilities'],
      packages: json['packages'],
      location: json['location'],
      gymreviews: json['gymreviews'],
      open_close_time: json['open_close_time']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'image': image,
      'name': name,
      'place': place,
      'id_gym': id_gym,
      'facilities': facilities,
      'package': packages,
      'location': location,
      'gymreviews': gymreviews,
      'open_close_time': open_close_time
    };
  }
}