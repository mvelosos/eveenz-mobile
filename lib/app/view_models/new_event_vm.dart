class NewEventVM {
  String name = '';
  String description = '';
  String privacy = '';
  String startDate = '';
  String endDate = '';
  String startTime = '';
  String endTime = '';
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
        'addressAttributes': _getAddressData(),
        'localizationAttributes': _getLocalizationData(),
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
