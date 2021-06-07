class ProfileModel {
  late Account account;

  ProfileModel({required this.account});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    account = new Account.fromJson(json['account']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account.toJson();
    return data;
  }
}

class Account {
  late String uuid;
  late String username;
  late String name;
  late int popularity;
  late int events;
  late int following;
  late int followers;
  String? bio;
  String? avatarUrl;

  Account(
      {required this.uuid,
      required this.username,
      required this.name,
      required this.popularity,
      required this.events,
      required this.following,
      required this.followers,
      this.bio,
      this.avatarUrl});

  Account.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    username = json['username'];
    name = json['name'];
    bio = json['bio'];
    popularity = json['popularity'];
    events = json['events'];
    following = json['following'];
    followers = json['followers'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['username'] = this.username;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['popularity'] = this.popularity;
    data['events'] = this.events;
    data['following'] = this.following;
    data['followers'] = this.followers;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
