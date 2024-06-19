import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? phone;
  String? name;
  String? pass;
  String? avatar;
  String? address;
  double? latitude;
  double? longitude;

  UserModel({
    required this.email,
    required this.phone,
    required this.name,
    required this.pass,
    required this.avatar,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        pass: json["pass"],
        avatar: json["avatar"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
        "name": name,
        "pass": pass,
        "avatar": avatar,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
