class AccountFollowModel {
  late String uuid;
  late String name;
  late String username;
  late String avatarUrl;

  AccountFollowModel({
    required this.uuid,
    required this.name,
    required this.username,
    required this.avatarUrl,
  });

  AccountFollowModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    username = json['username'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['username'] = this.username;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
