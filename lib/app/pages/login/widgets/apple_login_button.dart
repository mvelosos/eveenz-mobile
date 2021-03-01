import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';
import 'package:party_mobile/app/view_models/apple_login_vm.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginButton extends StatelessWidget {
  final Function _setLoading;
  final LoginController _loginController = locator<LoginController>();
  final LocalStorageService _localStorage = locator<LocalStorageService>();
  final AppleLoginVM _appleLogin = AppleLoginVM();
  final NavigationService _navigationService;

  AppleLoginButton(this._setLoading, this._navigationService);

  _initAppleLogin(BuildContext context) async {
    if (await SignInWithApple.isAvailable() == false) return;

    AuthorizationCredentialAppleID credentials;

    try {
      credentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      _setLoading(true);

      // if (credentials.identityToken != null &&
      //     credentials.identityToken.isNotEmpty) {
      //   await _storeAppleJwt(credentials.identityToken);
      // }
      // TODO: FIX THIS

      _getAppleJwt().then((value) => print(value));

      _appleLogin.userId = credentials.userIdentifier;
      _appleLogin.jwt = await _getAppleJwt();

      _loginController
          .loginWithApple(_appleLogin)
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
    } catch (e) {
      _setLoading(false);
    }
  }

  Future<void> _storeAppleJwt(jwtApple) async {
    await _localStorage.put(Storage.jwtApple, jwtApple);
  }

  Future<String> _getAppleJwt() async {
    return await _localStorage.get(Storage.jwtApple);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _initAppleLogin(context);
      },
      splashColor: Colors.transparent,
      child: Image(
        image: AssetImage('assets/images/apple_button.png'),
        height: size.height * .06,
      ),
    );
  }
}
