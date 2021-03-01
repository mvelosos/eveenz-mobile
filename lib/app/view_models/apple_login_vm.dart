class AppleLoginVM {
  String userId;
  String jwt;

  Map<String, dynamic> getData() {
    return {
      'apple': {'userId': userId, 'jwt': jwt}
    };
  }
}
