import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/repositories/auth_repository.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/stores/login_store.dart';
import 'package:party_mobile/app/view_models/facebook_login_vm.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';

import '../locator.dart';

class LoginController {
  AuthRepository _authRepository;
  NavigationService _navigation;
  LoginStore _loginStore;

  LoginController() {
    _authRepository = AuthRepository();
    _navigation = locator<NavigationService>();
    _loginStore = locator<LoginStore>();
  }

  Future<Either<Failure, AuthUserModel>> loginWithEmail(
      UserLoginVM userLogin) async {
    _loginStore.setLoading(true);
    var authResult = await _authRepository.authLogin(userLogin);
    if (authResult.isRight()) {
      _setLocalStorage(authResult.getOrElse(null));
      _navigation.pushNamed(RouteNames.appContainer);
    }
    _loginStore.setLoading(false);
    return authResult;
  }

  Future<Either<Failure, AuthUserModel>> loginWithFacebook(
      FacebookLoginVM fbLogin) async {
    _loginStore.setLoading(true);
    var authUser = await _authRepository.authFacebook(fbLogin);
    authUser.fold(
        (l) => null,
        (r) => {
              _setLocalStorage(r),
              _navigation.pushNamed(RouteNames.appContainer)
            });
    _loginStore.setLoading(false);
  }

  _setLocalStorage(AuthUserModel authUser) {
    var localStorage = locator<LocalStorageService>();
    localStorage.put(Storage.jwtToken, authUser.token);
  }
}
