class User {
  int? uid;
  String? email;
  String? name;
  String? username;
  String? password;
  String? photoUrl;
  String? dateofbirth;

  User({this.uid, this.email, this.name, this.photoUrl, this.dateofbirth, this.password, this.username});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    username = json['username'];
    photoUrl = json['photoUrl'];
    dateofbirth = json['dateofbirth'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'username': username,
      'password': password,
      'profilepicture': photoUrl,
      'dateofbirth': dateofbirth
    };
  }
}