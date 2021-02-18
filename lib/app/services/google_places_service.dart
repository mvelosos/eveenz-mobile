import 'package:dio/dio.dart';
import 'package:party_mobile/app/shared/constants/api_keys.dart';

class GooglePlacesService {
  static final String kGoogleApiKey = ApiKeys.kGoogleApiKey;
  static final String searchFields = 'place_id,formatted_address,geometry';
  static final String searchPlacesUrl =
      'https://maps.googleapis.com/maps/api/place/findplacefromtext/json';

  static Future<dynamic> getSearchResults(String searchText) async {
    String url =
        '$searchPlacesUrl?input=$searchText&key=$kGoogleApiKey&inputtype=textquery&fields=$searchFields';
    Response response = await Dio().get(url);
    return response.data['candidates'];
  }
}
