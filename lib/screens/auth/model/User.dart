// ignore_for_file: file_names

class User {
  int? uid;
  String? email;
  String? name;
  String? username;
  String? password;
  String? photoUrl;
  String? dateofbirth;
  String? phoneNumber;
  String? address;
  String? height;
  String? weight;


  User({this.uid, this.email, this.name, this.photoUrl, this.dateofbirth, this.password, this.username,this.phoneNumber,this.address,this.height,this.weight});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    username = json['username'];
    photoUrl = json['photoUrl'];
    dateofbirth = json['dateofbirth'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    height = json['height'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'username': username,
      'password': password,
      'profilepicture': photoUrl,
      'dateofbirth': dateofbirth,
      'phone_number': phoneNumber,
      'address': address,
      'height': height,
      'weight': weight,
    };
  }
}