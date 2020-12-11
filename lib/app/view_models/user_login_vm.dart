class UserLoginVM {
  String login = '';
  String password = '';

  Map<String, dynamic> getData() {
    return {
      'user': {'login': login, 'password': password}
    };
  }
}
