class AuthUserModel {
  String username;
  String createdAt;
  String token;
  String tokenType;
  String exp;
  String provider;

  AuthUserModel(
      {this.username,
      this.createdAt,
      this.token,
      this.tokenType,
      this.exp,
      this.provider});

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    createdAt = json['createdAt'];
    token = json['token'];
    tokenType = json['tokenType'];
    exp = json['exp'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['createdAt'] = this.createdAt;
    data['token'] = this.token;
    data['tokenType'] = this.tokenType;
    data['exp'] = this.exp;
    data['provider'] = this.provider;
    return data;
  }
}
