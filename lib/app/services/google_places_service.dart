import 'dart:math';

import 'package:dio/dio.dart';
import 'package:party_mobile/app/shared/constants/api_keys.dart';

class GooglePlacesService {
  static final String kGoogleApiKey = ApiKeys.kGoogleApiKey;
  static final String placesAutocompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static final String placeDetailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';
  static final fields = 'formatted_address,geometry,address_component';

  static String generateSessionToken() {
    var random = new Random();
    var listRandom = new List.generate(12, (_) => random.nextInt(100));
    return listRandom.join('');
  }

  static Future<dynamic> getPlacesAutocomplete(
      String searchText, String sessionToken) async {
    String url =
        '$placesAutocompleteUrl?input=$searchText&key=$kGoogleApiKey&sessiontoken=$sessionToken';
    Response response = await Dio().get(url);
    return response.data['predictions'];
  }

  static Future<dynamic> getPlaceDetails(
      String placeId, String sessionToken) async {
    String url =
        '$placeDetailsUrl?place_id=$placeId&fields=$fields&key=$kGoogleApiKey&sessiontoken=$sessionToken';
    Response response = await Dio().get(url);
    return response.data;
  }
}
