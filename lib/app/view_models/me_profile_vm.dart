class MeProfileVM {
  String name;
  String bio;
  int popularity;
  double latitude;
  double longitude;
  String street;
  String number;
  String complement;
  String neighborhood;
  String zipCode;
  String city;
  String state;
  String country;

  Map<String, dynamic> getData() {
    Map<String, dynamic> account = {};
    if (latitude != null || longitude != null) {
      account.putIfAbsent('localizationAttributes', () => {});
    }

    if (street != null ||
        number != null ||
        complement != null ||
        neighborhood != null ||
        zipCode != null ||
        city != null ||
        state != null ||
        country != null) {
      account.putIfAbsent('addressAttributes', () => {});
    }

    if (name != null) account['name'] = name;
    if (bio != null) account['bio'] = bio;
    if (popularity != null) account['popularity'] = popularity;
    if (latitude != null)
      account['localizationAttributes']['latitude'] = latitude;
    if (longitude != null)
      account['localizationAttributes']['longitude'] = longitude;
    if (street != null) account['addressAttributes']['street'] = street;
    if (number != null) account['addressAttributes']['number'] = number;
    if (complement != null)
      account['addressAttributes']['complement'] = complement;
    if (neighborhood != null)
      account['addressAttributes']['neighborhood'] = neighborhood;
    if (zipCode != null) account['addressAttributes']['zipCode'] = zipCode;
    if (city != null) account['addressAttributes']['city'] = city;
    if (state != null) account['addressAttributes']['state'] = state;
    if (country != null) account['addressAttributes']['country'] = country;

    return {
      'account': account,
    };
  }
}
