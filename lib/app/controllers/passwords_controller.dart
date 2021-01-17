import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/repositories/passwords_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/password_forgot_email_vm.dart';
import 'package:party_mobile/app/view_models/password_recovery_vm.dart';

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

  Future<Either<Failure, dynamic>> verifyCode(
      PasswordRecoveryVM passwordRecovery) async {
    var result = await _passwordsRepository.verifyCode(passwordRecovery);
    return result;
  }

  Future<Either<Failure, dynamic>> recoverPassword(
      PasswordRecoveryVM passwordRecovery) async {
    var result = await _passwordsRepository.recoverPassword(passwordRecovery);
    return result;
  }
}
