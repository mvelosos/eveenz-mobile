class NotificationModel {
  String? notificationType;
  Follower? follower;
  RequestedBy? requestedBy;
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
    requestedBy = json['requestedBy'] != null
        ? new RequestedBy.fromJson(json['requestedBy'])
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
    if (this.requestedBy != null) {
      data['requestedBy'] = this.requestedBy!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['followedByMe'] = this.followedByMe;
    return data;
  }
}

class Follower {
  String? uuid;
  String? name;
  String? username;
  String? avatarUrl;

  Follower({this.name, this.username});

  Follower.fromJson(Map<String, dynamic> json) {
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

class RequestedBy {
  String? uuid;
  String? name;
  String? username;
  String? avatarUrl;

  RequestedBy({this.name, this.username});

  RequestedBy.fromJson(Map<String, dynamic> json) {
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
