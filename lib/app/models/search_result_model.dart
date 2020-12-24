class SearchResult {
  List<Data> data;

  SearchResult({this.data});

  SearchResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String uuid;
  String type;
  String username;
  String name;
  String avatarUrl;
  String imageUrl;
  String distance;

  Data(
      {this.uuid,
      this.type,
      this.username,
      this.name,
      this.avatarUrl,
      this.imageUrl,
      this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'] ?? null;
    type = json['type'] ?? null;
    username = json['username'] ?? null;
    name = json['name'] ?? null;
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
