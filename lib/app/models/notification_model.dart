class NotificationModel {
  String? notificationType;
  Follower? follower;
  String? createdAt;
  bool? followedByMe;

  NotificationModel({
    this.notificationType,
    this.follower,
    this.createdAt,
    this.followedByMe,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notificationType = json['notificationType'];
    follower = json['follower'] != null
        ? new Follower.fromJson(json['follower'])
        : null;
    createdAt = json['createdAt'];
    followedByMe = json['followedByMe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationType'] = this.notificationType;
    if (this.follower != null) {
      data['follower'] = this.follower!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['followedByMe'] = this.followedByMe;
    return data;
  }
}

class Follower {
  String? name;
  String? username;

  Follower({this.name, this.username});

  Follower.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    return data;
  }
}
