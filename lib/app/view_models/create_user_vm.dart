class CreateUserVM {
  String username = '';
  String email = '';
  String password = '';

  Map<String, dynamic> getData() {
    return {
      'user': {
        'email': email,
        'password': password,
        'accountAttributes': {'username': username}
      }
    };
  }
}
