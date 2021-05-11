class NewEventVM {
  String name;
  String description;
  String privacy;
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  bool undefinedEnd = false;
  String externalUrl;
  int minimumAge;
  List<Map> images = [];
  Map<String, dynamic> addressAttributes = {
    'street': '',
    'number': '',
    'neighborhood': '',
    'city': '',
    'state': '',
    'country': '',
    'zipCode': '',
    'complement': ''
  };
  Map<String, dynamic> localizationAttributes = {
    'latitude': '',
    'longitude': '',
  };
  List<Map<String, dynamic>> eventCategories = [];

  Map<String, dynamic> getData() {
    return {
      'event': {
        'name': name.trim(),
        'description': description.trim(),
        'privacy': privacy,
        'startDate': startDate,
        'endDate': endDate,
        'startTime': startTime,
        'endTime': endTime,
        'undefinedEnd': undefinedEnd,
        'externalUrl': externalUrl,
        'minimumAge': minimumAge,
        'images': images,
        'addressAttributes': _getAddressData(),
        'localizationAttributes': _getLocalizationData(),
        'eventCategoriesAttributes': eventCategories,
      }
    };
  }

  Map<String, dynamic> _getAddressData() {
    return {
      'street': addressAttributes['street'],
      'number': addressAttributes['number'],
      'neighborhood': addressAttributes['neighborhood'],
      'city': addressAttributes['city'],
      'state': addressAttributes['state'],
      'country': addressAttributes['country'],
      'zipCode': addressAttributes['zipCode'],
      'complement': addressAttributes['complement'],
    };
  }

  Map<String, dynamic> _getLocalizationData() {
    return {
      'latitude': localizationAttributes['latitude'],
      'longitude': localizationAttributes['longitude'],
    };
  }
}
