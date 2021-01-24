import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';

class GoogleLoginButton extends StatelessWidget {
  final LoginController _loginController;

  GoogleLoginButton(this._loginController);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        print('login with google');
      },
      splashColor: Colors.transparent,
      child: Image(
        image: AssetImage('assets/images/google_button.png'),
        height: size.height * .06,
      ),
    );
  }
}
