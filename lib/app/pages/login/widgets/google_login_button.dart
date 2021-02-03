import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginButton extends StatelessWidget {
  final LoginController _loginController;

  GoogleLoginButton(this._loginController);

  // Functions

  Future<void> _initGoogleLogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      var result = await _googleSignIn.signIn();
      result.authentication.then((value) => {print(value.accessToken)});
      print(result.id);
      print(result.email);
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
