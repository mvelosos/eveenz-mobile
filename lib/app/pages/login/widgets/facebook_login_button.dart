import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/view_models/facebook_login_vm.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookLoginButton extends StatelessWidget {
  final Function _setLoading;
  final FacebookLoginVM _fbLogin = FacebookLoginVM();
  final LoginController _loginController = locator<LoginController>();
  final NavigationService _navigationService;

  FacebookLoginButton(this._setLoading, this._navigationService);

  _initFacebookLogin() async {
    _setLoading(true);
    final facebookLogin = FacebookLogin();
    const permissions = ['email'];

    final result = await facebookLogin.logIn(permissions);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _fbLogin.accessToken = result.accessToken.token;
        _loginController
            .loginWithFacebook(_fbLogin)
            .then(
              (value) => {
                value.fold(
                  (l) => null,
                  (r) => {
                    _navigationService.pushReplacementNamedNoAnimation(
                      RouteNames.appContainer,
                    )
                  },
                )
              },
            )
            .whenComplete(() => _setLoading(false));
        break;
      case FacebookLoginStatus.cancelledByUser:
        _setLoading(false);
        break;
      case FacebookLoginStatus.error:
        _setLoading(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
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
