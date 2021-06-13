class GooglePlaceDetailsFormatter {
  static Map<String, dynamic> formatAddress(Map place) {
    List addressComponents = place['result']['address_components'];
    String number = _getStreetNumber(addressComponents);
    String street = _getStreet(addressComponents);
    String neighbourhood = _getNeighbourhood(addressComponents);
    String city = _getCity(addressComponents);
    String state = _getState(addressComponents);
    String country = _getCountry(addressComponents);
    String zipCode = _getZipCode(addressComponents);

    Map<String, dynamic> address = {
      'street': street,
      'number': number,
      'neighborhood': neighbourhood,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
    };

    return address;
  }

  static Map<String, dynamic> formatLocalization(Map place) {
    Map? localizationComponents = place['result']['geometry']['location'];
    double? latitude;
    double? longitude;

    if (localizationComponents != null) {
      latitude = localizationComponents['lat'];
      longitude = localizationComponents['lng'];
    }

    Map<String, dynamic> localization = {
      'latitude': latitude,
      'longitude': longitude
    };

    return localization;
  }

  static String _getStreetNumber(List components) {
    String number = '';

    components.forEach((element) {
      List types = element['types'];
      if (types.contains('street_number')) {
        number = element['long_name'];
      }
    });

    return number;
  }

  static String _getStreet(List components) {
    String street = '';

    components.forEach((element) {
      List types = element['types'];
      if (types.contains('route')) {
        street = element['long_name'];
      }
    });

    return street;
  }

  static String _getNeighbourhood(List components) {
    String neighbourhood = '';

    components.forEach((element) {
      List types = element['types'];
      if (types.contains(['neighborhood']) ||
          types.contains('sublocality_level_1')) {
        neighbourhood = element['long_name'];
      }
    });

    return neighbourhood;
  }

  static String _getCity(List components) {
    String city = '';

    for (var i = 0; i < components.length; i++) {
      List types = components[i]['types'];
      if (types.contains('locality')) {
        city = components[i]['long_name'];
        break;
      }
      if (types.contains('administrative_area_level_2')) {
        city = components[i]['long_name'];
      }
    }

    return city;
  }

  static String _getState(List components) {
    String state = '';

    components.forEach((element) {
      List types = element['types'];
      if (types.contains('administrative_area_level_1')) {
        state = element['short_name'];
      }
    });

    return state;
  }

  static String _getCountry(List components) {
    String country = '';

    components.forEach((element) {
      List types = element['types'];
      if (types.contains('country')) {
        country = element['long_name'];
      }
    });

    return country;
  }

  static String _getZipCode(List components) {
    String zipCode = '';

    components.forEach((element) {
      List types = element['types'];
      if (types.contains('postal_code')) {
        zipCode = element['long_name'];
      }
    });

    return zipCode;
  }
}
