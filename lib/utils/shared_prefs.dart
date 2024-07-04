import 'package:template/source/export.dart';

class SharedPrefs {
  static late SharedPreferences sharedPreferences;
  static const keyUserAddress = 'keyUserAddress';
  static const keyUserLatitude = 'keyUserLatitude';
  static const keyUserLongitude = 'keyUserLongitude';
  static const keyPhotoAccess = 'keyPhotoAccess';
  static LatLng userLocation() {
    if (currentUser != null &&
        currentUser!.latitude != null &&
        currentUser!.longitude != null) {
      return LatLng(currentUser!.latitude!, currentUser!.longitude!);
    } else {
      return const LatLng(kLatitude, kLongitude);
    }
  }

  static Future setString(String key, String value) async =>
      await sharedPreferences.setString(key, value);

  static String? getString(String key) => sharedPreferences.getString(key);

  static Future setDouble(String key, double value) async =>
      await sharedPreferences.setDouble(key, value);

  static double? getDouble(String key) => sharedPreferences.getDouble(key);

  static Future setBool(String key, bool value) async =>
      await sharedPreferences.setBool(key, value);

  static bool? getBool(String key) => sharedPreferences.getBool(key);
}
