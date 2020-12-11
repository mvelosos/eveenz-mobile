import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/repositories/auth_repository.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';

import '../locator.dart';

// TODO: Refactor this class later
class LoginController {
  AuthRepository _authRepository;
  NavigationService _navigation;

  LoginController() {
    _authRepository = AuthRepository();
    _navigation = locator<NavigationService>();
  }

  Future<Either<Failure, AuthUserModel>> loginWithEmail(
      UserLoginVM userLogin) async {
    var authUser = await _authRepository.authLogin(userLogin);
    authUser.fold(
        (l) => null,
        (r) => {
              _setLocalStorage(r),
              _navigation.pushNamed(RouteNames.appContainer)
            });
  }

  Future<Either<Failure, AuthUserModel>> loginWithFacebook(
      UserLoginVM userLogin) async {
    var authUser = await _authRepository.authLogin(userLogin);
    authUser.fold((l) => null, (r) => {_setLocalStorage(r), print(123)});
  }

  _setLocalStorage(AuthUserModel authUser) {
    var localStorage = locator<LocalStorageService>();
    localStorage.put(Storage.jwtToken, authUser.token);
  }
}
