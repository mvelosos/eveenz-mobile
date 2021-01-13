class PasswordForgotEmailVM {
  String email;

  Map<String, dynamic> getData() {
    return {
      'password': {
        'email': email,
      }
    };
  }
}
