import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/repositories/auth_repository.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/stores/auth_user_store.dart';
import 'package:party_mobile/app/stores/login_store.dart';
import 'package:party_mobile/app/view_models/facebook_login_vm.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';

class LoginController {
  AuthRepository _authRepository;
  NavigationService _navigationService;
  LoginStore _loginStore;
  AuthUserStore _authUserStore;

  LoginController() {
    _authRepository = AuthRepository();
    _navigationService =
        NavigationService(locator<RootNavigatorKey>().navigatorKey);
    _loginStore = locator<LoginStore>();
    _authUserStore = locator<AuthUserStore>();
  }

  Future<Either<Failure, AuthUserModel>> loginWithEmail(
      UserLoginVM userLogin) async {
    _loginStore.setLoading(true);
    var authResult = await _authRepository.authLogin(userLogin);
    if (authResult.isRight()) {
      _setLocalStorage(authResult.getOrElse(null));
      _authUserStore.setUser(authResult.getOrElse(null));
      _navigationService
          .pushReplacementNamedNoAnimation(RouteNames.appContainer);
    }
    _loginStore.setLoading(false);
    return authResult;
  }

  Future<Either<Failure, AuthUserModel>> loginWithFacebook(
      FacebookLoginVM fbLogin) async {
    _loginStore.setLoading(true);
    var authResult = await _authRepository.authFacebook(fbLogin);
    if (authResult.isRight()) {
      _setLocalStorage(authResult.getOrElse(null));
      _authUserStore.setUser(authResult.getOrElse(null));
      _navigationService
          .pushReplacementNamedNoAnimation(RouteNames.appContainer);
    }
    _loginStore.setLoading(false);
    return authResult;
  }

  _setLocalStorage(AuthUserModel authUser) {
    var localStorage = locator<LocalStorageService>();
    localStorage.put(Storage.jwtToken, authUser.token);
  }
}
