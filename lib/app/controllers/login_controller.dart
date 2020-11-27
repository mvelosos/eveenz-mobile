import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/repositories/auth_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';

class LoginController {
  AuthRepository _authRepository;

  LoginController() {
    _authRepository = AuthRepository();
  }

  Future<Either<Failure, AuthUserModel>> loginWithEmail(
      UserLoginVM userLogin) async {
    var authUser = await _authRepository.authLogin(userLogin);
  }
}
