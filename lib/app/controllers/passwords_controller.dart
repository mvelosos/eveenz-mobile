import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/repositories/passwords_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/password_forgot_email_vm.dart';

class PasswordsController {
  PasswordsRepository _passwordsRepository;

  PasswordsController() {
    _passwordsRepository = PasswordsRepository();
  }

  Future<Either<Failure, dynamic>> forgotPassword(
      PasswordForgotEmailVM passwordForgotEmail) async {
    var result = await _passwordsRepository.forgotPassword(passwordForgotEmail);
    return result;
  }
}
