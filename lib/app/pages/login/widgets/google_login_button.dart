import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/view_models/google_login_vm.dart';

class GoogleLoginButton extends StatelessWidget {
  final Function _setLoading;
  final GoogleLoginVM _googleLogin = GoogleLoginVM();
  final LoginController _loginController = locator<LoginController>();
  final NavigationService _navigationService;

  GoogleLoginButton(this._setLoading, this._navigationService);

  // Functions

  Future<void> _initGoogleLogin() async {
    _setLoading(true);
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      var result = await _googleSignIn.signIn();
      result.authentication.then(
        (value) => {
          _googleLogin.accessToken = value.accessToken,
          _loginController.loginWithGoogle(_googleLogin).then(
                (value) => {
                  print(value),
                  _setLoading(false),
                },
              )
        },
      );
    } catch (error) {
      print(error);
    }
  }

  // Widgets

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _initGoogleLogin();
      },
      splashColor: Colors.transparent,
      child: Image(
        image: AssetImage('assets/images/google_button.png'),
        height: size.height * .06,
      ),
    );
  }
}
