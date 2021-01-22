import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/stores/login_store.dart';
import 'package:party_mobile/app/view_models/facebook_login_vm.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookLoginButton extends StatelessWidget {
  final FacebookLoginVM _fbLogin = FacebookLoginVM();
  final LoginController _loginController;
  final LoginStore _loginStore;

  FacebookLoginButton(this._loginController, this._loginStore);

  _initFacebookLogin() async {
    final facebookLogin = FacebookLogin();
    const permissions = ['email'];

    final result = await facebookLogin.logIn(permissions);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _fbLogin.accessToken = result.accessToken.token;
        _loginController.loginWithFacebook(_fbLogin);
        break;
      case FacebookLoginStatus.cancelledByUser:
        _loginStore.setLoading(false);
        break;
      case FacebookLoginStatus.error:
        _loginStore.setLoading(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _loginStore.setLoading(true);
        _initFacebookLogin();
      },
      splashColor: Colors.transparent,
      child: Image(
        image: AssetImage('assets/images/facebook_button.png'),
        height: size.height * .06,
      ),
    );
  }
}
