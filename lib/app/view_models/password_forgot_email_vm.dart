class PasswordForgotEmailVM {
  String? login;

  Map<String, dynamic> getData() {
    return {
      'password': {
        'login': login?.trim(),
      }
    };
  }
}
