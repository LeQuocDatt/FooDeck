class UserModel {
  String? email, phone, name, pass, avatar, address;
  double? latitude, longitude;

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
}

UserModel? currentUser;
