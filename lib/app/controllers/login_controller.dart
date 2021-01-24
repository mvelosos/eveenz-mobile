import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/repositories/auth_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/shared/utils/commons.dart';
import 'package:party_mobile/app/stores/auth_user_store.dart';
import 'package:party_mobile/app/view_models/facebook_login_vm.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';

class LoginController {
  AuthRepository _authRepository;
  AuthUserStore _authUserStore;

  LoginController() {
    _authRepository = AuthRepository();
    _authUserStore = locator<AuthUserStore>();
  }

  Future<Either<Failure, AuthUserModel>> loginWithEmail(
      UserLoginVM userLogin) async {
    var authResult = await _authRepository.authLogin(userLogin);
    if (authResult.isRight()) {
      Commons.setAuthLocalStorage(authResult.getOrElse(null));
      _authUserStore.setUser(authResult.getOrElse(null));
    }
    return authResult;
  }

  Future<Either<Failure, AuthUserModel>> loginWithFacebook(
      FacebookLoginVM fbLogin) async {
    var authResult = await _authRepository.authFacebook(fbLogin);
    if (authResult.isRight()) {
      Commons.setAuthLocalStorage(authResult.getOrElse(null));
      _authUserStore.setUser(authResult.getOrElse(null));
    }
    return authResult;
  }
}
