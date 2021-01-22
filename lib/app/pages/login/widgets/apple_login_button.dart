import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/stores/login_store.dart';

class AppleLoginButton extends StatelessWidget {
  final LoginController _loginController;
  final LoginStore _loginStore;

  AppleLoginButton(this._loginController, this._loginStore);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        // _loginStore.setLoading(true);
      },
      splashColor: Colors.transparent,
      child: Image(
        image: AssetImage('assets/images/apple_button.png'),
        height: size.height * .06,
      ),
    );
  }
}
