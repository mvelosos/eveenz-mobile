import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/view_models/facebook_login_vm.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginButton extends StatelessWidget {
  final Function _setLoading;
  final FacebookLoginVM _fbLogin = FacebookLoginVM();
  final LoginController _loginController = locator<LoginController>();
  final NavigationService _navigationService;

  FacebookLoginButton(this._setLoading, this._navigationService);

  _initFacebookLogin(BuildContext context) async {
    _setLoading(true);

    const permissions = ['email'];

    final LoginResult result = await FacebookAuth.instance.login(
      permissions: permissions,
    );

    switch (result.status) {
      case LoginStatus.success:
        _fbLogin.accessToken = result.accessToken.token;
        _loginController
            .loginWithFacebook(_fbLogin)
            .then(
              (value) => {
                value.fold(
                  (l) => {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          l.message,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: AppColors.snackWarning,
                        behavior: SnackBarBehavior.floating,
                      ),
                    )
                  },
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
      case LoginStatus.cancelled:
        _setLoading(false);
        break;
      case LoginStatus.failed:
        _setLoading(false);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _initFacebookLogin(context);
      },
      splashColor: Colors.transparent,
      child: Image(
        image: AssetImage('assets/images/facebook_button.png'),
        height: size.height * .06,
      ),
    );
  }
}
