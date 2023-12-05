// ignore_for_file: non_constant_identifier_names

class ReviewGym {
  final DateTime date;
  final String description, name, photoURL;
  final int id_gym, rating;
  final List<dynamic> images;

  ReviewGym({
    required this.date,
    required this.description,
    required this.name,
    required this.photoURL,
    required this.id_gym,
    required this.rating,
    required this.images
  });

  factory ReviewGym.fromJson(Map<String, dynamic> json) {
    return ReviewGym(
      date: json['datetime'],
      description: json['description'],
      name: json['name'],
      photoURL: json['photoURL'],
      id_gym: json['id_gym'],
      rating: json['rating'],
      images: json['images']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'description': description,
      'name': name,
      'photoURL': photoURL,
      'id_gym': id_gym,
      'rating': rating,
      'images': images
    };
  }
}