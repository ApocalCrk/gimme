class DetailGym {
  final String description, image, name, place;
  final int id_gym;
  final Map<String, dynamic> facilities;
  final Map<String, dynamic> package;
  final String location;

  DetailGym({
    required this.description,
    required this.image,
    required this.name,
    required this.place,
    required this.id_gym,
    required this.facilities,
    required this.package,
    required this.location
  });

  factory DetailGym.fromJson(Map<String, dynamic> json) {
    return DetailGym(
      description: json['description'],
      image: json['image'],
      name: json['name'],
      place: json['place'],
      id_gym: json['id_gym'],
      facilities: json['facilities'],
      package: json['package'],
      location: json['location']
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
      'package': package,
      'location': location
    };
  }
}