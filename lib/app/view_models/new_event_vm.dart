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
  List images = [];

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
        'addressAttributes': _getAddressData(),
        'localizationAttributes': _getLocalizationData(),
        'eventCategoriesAttributes': eventCategories,
        'images': images,
      }
    };
  }

  Map<String, dynamic> _getAddressData() {
    return {
      'street': addressAttributes['street'].trim(),
      'number': addressAttributes['number'].trim(),
      'neighborhood': addressAttributes['neighborhood'].trim(),
      'city': addressAttributes['city'].trim(),
      'state': addressAttributes['state'].trim(),
      'country': addressAttributes['country'].trim(),
      'zipCode': addressAttributes['zipCode'].trim(),
      'complement': addressAttributes['complement'].trim(),
    };
  }

  Map<String, dynamic> _getLocalizationData() {
    return {
      'latitude': localizationAttributes['latitude'],
      'longitude': localizationAttributes['longitude'],
    };
  }
}
