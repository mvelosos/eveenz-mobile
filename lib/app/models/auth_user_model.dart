class AuthUserModel {
  late String username;
  late String createdAt;
  late String token;
  late String tokenType;
  late String exp;
  late String provider;

  AuthUserModel({
    required this.username,
    required this.createdAt,
    required this.token,
    required this.tokenType,
    required this.exp,
    required this.provider,
  });

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
