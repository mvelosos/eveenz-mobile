class GoogleLoginVM {
  String accessToken;

  Map<String, dynamic> getData() {
    return {
      'google': {'glAccessToken': accessToken}
    };
  }
}
