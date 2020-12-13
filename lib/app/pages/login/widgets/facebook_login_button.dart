import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/view_models/facebook_login_vm.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookLoginButton extends StatelessWidget {
  final FacebookLoginVM _fbLogin = FacebookLoginVM();
  final LoginController _loginController;
  final BoxConstraints _constraints;

  FacebookLoginButton(this._loginController, this._constraints);

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
        // _showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        // _showErrorOnUI(result.errorMessage);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        _initFacebookLogin();
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: _constraints.maxHeight * .007),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1959a9),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'f',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff2872ba),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Log in with Facebook',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
