class AccountModel {
  Account account;

  AccountModel({this.account});

  AccountModel.fromJson(Map<String, dynamic> json) {
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    return data;
  }
}

class Account {
  String username;
  String name;
  String bio;
  int popularity;
  int events;
  int following;
  int followers;
  String avatarUrl;

  Account(
      {this.username,
      this.name,
      this.bio,
      this.popularity,
      this.events,
      this.following,
      this.followers,
      this.avatarUrl});

  Account.fromJson(Map<String, dynamic> json) {
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
