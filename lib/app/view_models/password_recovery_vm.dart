class PasswordRecoveryVM {
  String? code;
  String? token;
  String? password;
  String? passwordConfirmation;

  Map<String, dynamic> getData() {
    return {
      'passwordRecovery': {
        'code': code,
        'token': token,
        'password': password,
        'passwordConfirmation': passwordConfirmation
      },
    };
  }
}
