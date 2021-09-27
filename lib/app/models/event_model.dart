import 'package:party_mobile/app/models/category_model.dart';

class EventModel {
  String? uuid;
  String? name;
  String? description;
  List<String?> images = [];
  String? distance;
  String? privacy;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  bool? undefinedEnd;
  String? externalUrl;
  int? minimumAge;
  String? hostAvatar;
  String? hostName;
  String? hostUsername;
  Address? address;
  Localization? localization;
  List<CategoryModel>? categories;

  EventModel({
    this.uuid,
    this.name,
    this.description,
    this.distance,
    this.privacy,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.undefinedEnd,
    this.externalUrl,
    this.minimumAge,
    this.hostAvatar,
    this.hostName,
    this.address,
    this.localization,
    this.categories,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    distance = json['distance'];
    privacy = json['privacy'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    undefinedEnd = json['undefinedEnd'];
    externalUrl = json['externalUrl'];
    minimumAge = json['minimumAge'];
    hostAvatar = json['hostAvatar'];
    hostName = json['hostName'];
    hostUsername = json['hostUsername'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    localization = json['localization'] != null
        ? new Localization.fromJson(json['localization'])
        : null;
    categories = [];
    if (json['categories'] != null || json['categories'] != []) {
      json['categories'].forEach(
        (category) => categories?.add(
          CategoryModel.fromJson(category),
        ),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    data['distance'] = this.distance;
    data['privacy'] = this.privacy;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['undefinedEnd'] = this.undefinedEnd;
    data['externalUrl'] = this.externalUrl;
    data['minimumAge'] = this.minimumAge;
    data['hostAvatar'] = this.hostAvatar;
    data['hostName'] = this.hostName;
    data['hostUsername'] = this.hostUsername;
    if (this.address != null) {
      data['address'] = this.address?.toJson();
    }
    if (this.localization != null) {
      data['localization'] = this.localization?.toJson();
    }
    if (this.categories != null) {
      List<Map> categoriesData = [];
      this.categories?.forEach((element) {
        categoriesData.add(element.toJson());
      });
      data['categories'] = categoriesData;
    }
    return data;
  }
}

class Address {
  String? street;
  String? number;
  String? complement;
  String? neighborhood;
  String? zipCode;
  String? city;
  String? state;
  String? country;

  Address({
    this.street,
    this.number,
    this.complement,
    this.neighborhood,
    this.zipCode,
    this.city,
    this.state,
    this.country,
  });

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    number = json['number'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    zipCode = json['zipCode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['number'] = this.number;
    data['complement'] = this.complement;
    data['neighborhood'] = this.neighborhood;
    data['zipCode'] = this.zipCode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}

class Localization {
  double? latitude;
  double? longitude;

  Localization({this.latitude, this.longitude});

  Localization.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
