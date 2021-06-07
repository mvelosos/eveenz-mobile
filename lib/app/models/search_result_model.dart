class SearchResultModel {
  late List<Data?> listData;

  SearchResultModel({required this.listData});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listData = [];
      json['data'].forEach((v) {
        listData.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.listData.map((v) => v?.toJson()).toList();
    return data;
  }
}

class Data {
  late String uuid;
  late String type;
  late String name;
  String? username;
  String? avatarUrl;
  String? imageUrl;
  String? distance;

  Data({
    required this.uuid,
    required this.type,
    required this.name,
    this.username,
    this.avatarUrl,
    this.imageUrl,
    this.distance,
  });

  Data.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'] ?? null;
    type = json['type'] ?? null;
    username = json['username'] ?? null;
    name = json['name'] ?? '';
    avatarUrl = json['avatar_url'] ?? null;
    imageUrl = json['image_url'] ?? null;
    distance = json['distance'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['type'] = this.type;
    data['username'] = this.username;
    data['name'] = this.name;
    data['avatar_url'] = this.avatarUrl;
    data['image_url'] = this.imageUrl;
    data['distance'] = this.distance;
    return data;
  }
}
