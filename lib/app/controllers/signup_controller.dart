import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/repositories/users_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/shared/utils/commons.dart';
import 'package:party_mobile/app/stores/auth_user_store.dart';
import 'package:party_mobile/app/view_models/create_user_vm.dart';

class SignUpController {
  UsersRepository _usersRepository = UsersRepository();
  AuthUserStore _authUserStore = locator<AuthUserStore>();

  Future<Either<Failure, AuthUserModel>> createUser(
      CreateUserVM createUser) async {
    var userResult = await _usersRepository.createUser(createUser);
    if (userResult.isRight()) {
      Commons.setAuthLocalStorage(
          userResult.getOrElse(() => {} as AuthUserModel));
      _authUserStore.setUser(userResult.getOrElse(() => {} as AuthUserModel));
    }
    return userResult;
  }
}
