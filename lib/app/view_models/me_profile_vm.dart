class MeProfileVM {
  String? username;
  String? email;
  String? name;
  String? bio;
  int? popularity;
  Map? avatar;
  double? latitude;
  double? longitude;
  String? street;
  String? number;
  String? complement;
  String? neighborhood;
  String? zipCode;
  String? city;
  String? state;
  String? country;
  bool? private;

  Map<String, dynamic> getData() {
    Map<String, dynamic> account = {};
    if (username != null || email != null) {
      account.putIfAbsent('userAttributes', () => {});
    }

    if (private != null) {
      account.putIfAbsent('accountSettingAttributes', () => {});
    }

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

    if (username != null) account['userAttributes']['username'] = username;
    if (email != null) account['userAttributes']['email'] = email;
    if (name != null) account['name'] = name;
    if (bio != null) account['bio'] = bio;
    if (popularity != null) account['popularity'] = popularity;
    if (avatar != null) account['avatar'] = avatar;
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
    if (private != null)
      account['accountSettingAttributes']['private'] = private;

    return {
      'account': account,
    };
  }
}
