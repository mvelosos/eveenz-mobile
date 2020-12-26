class UserModel {
  User user;

  UserModel({this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String username = '';
  String email = '';
  String provider = '';
  String createdAt = '';

  User({this.username, this.email, this.provider, this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
