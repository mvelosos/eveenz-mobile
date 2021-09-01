class AccountModel {
  late String uuid;
  late String username;
  late String name;
  late int popularity;
  late int events;
  late int following;
  late int followers;
  late bool followedByMe;
  late bool privateAccount;
  Map? requestedByMe;
  String? bio;
  String? avatarUrl;

  AccountModel({
    required this.uuid,
    required this.username,
    required this.name,
    required this.popularity,
    required this.events,
    required this.following,
    required this.followers,
    required this.followedByMe,
    required this.privateAccount,
    this.requestedByMe,
    this.bio,
    this.avatarUrl,
  });

  AccountModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    username = json['username'];
    name = json['name'] ?? '';
    bio = json['bio'];
    popularity = json['popularity'];
    events = json['events'];
    following = json['following'];
    followers = json['followers'];
    avatarUrl = json['avatarUrl'];
    followedByMe = json['followedByMe'];
    privateAccount = json['privateAccount'];
    if (json['requestedByMe'] != null) {
      requestedByMe = json['requestedByMe'];
    }
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
    data['followedByMe'] = this.followedByMe;
    data['privateAccount'] = this.privateAccount;
    if (data['requestedByMe'] != null) {
      data['requestedByMe'] = this.requestedByMe;
    }
    return data;
  }
}
