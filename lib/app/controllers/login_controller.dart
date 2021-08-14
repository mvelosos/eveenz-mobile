import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/repositories/auth_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/shared/utils/commons.dart';
import 'package:party_mobile/app/stores/app_store.dart';
import 'package:party_mobile/app/stores/auth_user_store.dart';
import 'package:party_mobile/app/view_models/apple_login_vm.dart';
import 'package:party_mobile/app/view_models/facebook_login_vm.dart';
import 'package:party_mobile/app/view_models/google_login_vm.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';

class LoginController {
  AuthRepository _authRepository = AuthRepository();
  AuthUserStore _authUserStore = locator<AuthUserStore>();
  AppStore _appStore = locator<AppStore>();

  Future<Either<Failure, AuthUserModel>> loginWithEmail(
      UserLoginVM userLogin) async {
    var authResult = await _authRepository.authLogin(userLogin);
    if (authResult.isRight()) {
      _initLogin(authResult);
    }
    return authResult;
  }

  Future<Either<Failure, AuthUserModel>> loginWithFacebook(
      FacebookLoginVM fbLogin) async {
    var authResult = await _authRepository.authFacebook(fbLogin);
    if (authResult.isRight()) {
      _initLogin(authResult);
    }
    return authResult;
  }

  Future<Either<Failure, AuthUserModel>> loginWithGoogle(
      GoogleLoginVM googleLogin) async {
    var authResult = await _authRepository.authGoogle(googleLogin);
    if (authResult.isRight()) {
      _initLogin(authResult);
    }
    return authResult;
  }

  Future<Either<Failure, AuthUserModel>> loginWithApple(
      AppleLoginVM appleLogin) async {
    var authResult = await _authRepository.authApple(appleLogin);
    if (authResult.isRight()) {
      _initLogin(authResult);
    }
    return authResult;
  }

  _initLogin(Either<Failure, AuthUserModel> authResult) {
    Commons.setAuthLocalStorage(
        authResult.getOrElse(() => {} as AuthUserModel));
    _authUserStore.setUser(authResult.getOrElse(() => {} as AuthUserModel));
    _appStore.userAuthenticated.value = true;
  }
}
