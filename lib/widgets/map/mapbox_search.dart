import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:template/config/const.dart';
import 'package:template/utils/shared_prefs.dart';
import 'package:template/widgets/map/dio_exception.dart';

String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
String searchType =
    'country%2Cregion%2Cpostcode%2Cdistrict%2Cplace%2Clocality%2Cneighborhood%2Caddress%2Cpoi';
String searchResultsLimit = '6';
String country = 'vn';
String proximity =
    '${SharedPrefs.getDouble(SharedPrefs.keyUserLongitude) ?? kLongitude}%2C${SharedPrefs.getDouble(SharedPrefs.keyUserLatitude) ?? kLatitude}';
Dio _dio = Dio();

Future getSearchResultsFromQueryUsingMapbox(String query) async {
  String url =
      '$baseUrl/$query.json?country=$country&limit=$searchResultsLimit&proximity=$proximity&types=$searchType&access_token=$accessToken';
  url = Uri.parse(url).toString();

  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    if (responseData.data.isEmpty) {
      return [];
    } else {
      return responseData.data;
    }
  } catch (e) {
    final errorMessage =
        DioExceptions.fromDioError(e as DioException).toString();
    debugPrint(errorMessage);
  }
}
