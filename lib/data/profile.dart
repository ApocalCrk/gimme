import 'dart:convert';


class Profile{
        String uid;
        String name;
        String username;
        String email;
        String password;
        String profilepicture;
        String dateofbirth;

        Profile({
            required this.uid,
            required this.name,
            required this.username,
            required this.email,
            required this.password,
            required this.profilepicture,
            required this.dateofbirth,
        });
          factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));
          factory Profile.fromJson(Map<String, dynamic> json) => Profile(
            uid: json["uid"],
            name: json["name"],
            username: json["username"],
            email: json["email"],
            password: json["password"],
            profilepicture: json["profilepicture"],
            dateofbirth: json["dateofbirth"],
        );

        String toRawJson() => json.encode(toJson());
        Map<String, dynamic> toJson() => {
            "name": name,
            "username": username,
            "email": email,
            "password": password,
            "profilepicture": profilepicture,
            "dateofbirth": dateofbirth,
        };
}