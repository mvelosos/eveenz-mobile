class AccountModel {
  String uuid;
  String username;
  String name;
  String bio;
  int popularity;
  int events;
  int following;
  int followers;
  String avatarUrl;
  bool followedByMe;

  AccountModel(
      {this.uuid,
      this.username,
      this.name,
      this.bio,
      this.popularity,
      this.events,
      this.following,
      this.followers,
      this.avatarUrl,
      this.followedByMe});

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
    return data;
  }
}
