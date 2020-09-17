import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookLoginService {
  FacebookLogin _facebookLogin;

  FacebookLoginService() {
    _facebookLogin = FacebookLogin();
  }

  Future<FacebookLoginResult> login() async {
    var result = await _facebookLogin.logIn(['email']);
    return result;
  }

  Future<void> logout() async {
    await _facebookLogin.logOut();
  }
}
