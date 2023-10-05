import 'dart:convert';
import 'dart:developer';

import 'package:place_finder/model/place.dart';
import 'package:place_finder/utils/url_helper.dart';
import 'package:http/http.dart' as http;

class Webservice {
  Future<List<Place>> fetchPlacesByKeywordAndPosition(
      String keyword, double latitude, double longitude) async {
    final url =
        UrlHelper.urlForKeywordAndLocation(keyword, latitude, longitude);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      log(response.body);
      var jsonResponse = jsonDecode(response.body);
      Iterable list = jsonResponse['results'];
      return list.map((place) => Place.fromJSON(place)).toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
