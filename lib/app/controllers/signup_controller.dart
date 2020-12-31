import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/repositories/users_repository.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/stores/auth_user_store.dart';
import 'package:party_mobile/app/stores/signup_store.dart';
import 'package:party_mobile/app/view_models/create_user_vm.dart';

class SignUpController {
  UsersRepository _usersRepository;
  NavigationService _navigationService;
  SignUpStore _signUpStore;
  AuthUserStore _authUserStore;

  SignUpController() {
    _usersRepository = UsersRepository();
    _navigationService =
        NavigationService(locator<RootNavigatorKey>().navigatorKey);
    _signUpStore = locator<SignUpStore>();
    _authUserStore = locator<AuthUserStore>();
  }

  Future<Either<Failure, AuthUserModel>> createUser(
      CreateUserVM createUser) async {
    _signUpStore.setLoading(true);
    var userResult = await _usersRepository.createUser(createUser);
    if (userResult.isRight()) {
      _setLocalStorage(userResult.getOrElse(null));
      _authUserStore.setUser(userResult.getOrElse(null));
      _navigationService
          .pushReplacementNamedNoAnimation(RouteNames.appContainer);
    }
    _signUpStore.setLoading(false);
    return userResult;
  }

  _setLocalStorage(AuthUserModel authUser) {
    var localStorage = locator<LocalStorageService>();
    localStorage.put(Storage.jwtToken, authUser.token);
  }
}
