class FacebookLoginVM {
  String accessToken;

  Map<String, dynamic> getData() {
    return {
      'facebook': {'accessToken': accessToken}
    };
  }
}
