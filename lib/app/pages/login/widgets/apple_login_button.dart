import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginButton extends StatelessWidget {
  final LoginController _loginController;

  AppleLoginButton(this._loginController);

  _initAppleLogin() async {
    AuthorizationCredentialAppleID credential;

    try {
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
    } catch (e) {
      print(e);
    }

    print(credential);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _initAppleLogin();
      },
      splashColor: Colors.transparent,
      child: Image(
        image: AssetImage('assets/images/apple_button.png'),
        height: size.height * .06,
      ),
    );
  }
}
