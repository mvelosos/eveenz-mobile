import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';

class AppleLoginButton extends StatelessWidget {
  final LoginController _loginController;

  AppleLoginButton(this._loginController);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        print('login with apple');
      },
      splashColor: Colors.transparent,
      child: Image(
        image: AssetImage('assets/images/apple_button.png'),
        height: size.height * .06,
      ),
    );
  }
}
