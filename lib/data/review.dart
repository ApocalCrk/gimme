// ignore_for_file: non_constant_identifier_names

class ReviewGym {
  DateTime? created_at, updated_at;
  String? description;
  int? id_gym, uid, id_review;
  int? rating;
  List<dynamic>? images;
  Map<String, dynamic>? user;

  ReviewGym({
    this.id_review,
    this.created_at,
    this.updated_at,
    this.description,
    this.id_gym,
    this.rating,
    this.uid,
    this.images,
    this.user
  });

  factory ReviewGym.fromJson(Map<String, dynamic> json) {
    return ReviewGym(
      id_review: json['id_review'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
      description: json['description'],
      id_gym: json['id_gym'],
      rating: json['rating'],
      uid: json['uid'],
      images: json['images'],
      user: json['user']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id_review,
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString(),
      'description': description,
      'id_gym': id_gym,
      'rating': rating,
      'uid': uid,
      'images': images,
      'user': user
    };
  }
}