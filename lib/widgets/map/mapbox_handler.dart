import 'dart:convert';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:template/widgets/map/mapbox_reverse.dart';
import 'package:template/widgets/map/mapbox_search.dart';

// ----------------------------- Mapbox Search Query -----------------------------

Future<List> getParsedResponseForQuery(String value) async {
  List parsedResponses = [];

  final response = await getSearchResultsFromQueryUsingMapbox(value);

  List features = response['features'];
  for (var feature in features) {
    Map response = {
      'name': feature['text'],
      'address': feature['place_name'].split('${feature['text']}, ')[1],
      'place': feature['place_name'],
      'location': LatLng(feature['center'][1], feature['center'][0]),
      'latitude': feature['center'][1],
      'longitude': feature['center'][0],
      'area': feature['context'][0]['text'],
      'dist': feature['context'][2]['text'],
      'city': feature['context'][3]['text']
    };
    parsedResponses.add(response);
  }
  return parsedResponses;
}

// ----------------------------- Mapbox Reverse Geocoding -----------------------------
Future<Map> getParsedReverseGeocoding(LatLng latLng) async {
  var response =
      json.decode(await getReverseGeocodingGivenLatLngUsingMapbox(latLng));
  Map feature = response['features'][0];
  Map revGeocode = {
    'name': feature['text'],
    'address': feature['place_name'].split('${feature['text']}, ')[1],
    'place': feature['place_name'],
    'location': latLng
  };
  return revGeocode;
}
