import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/password_forgot_email_vm.dart';
import 'package:party_mobile/app/view_models/password_recovery_vm.dart';

abstract class IPasswordsRepository {
  Future<Either<Failure, Map>> forgotPassword(
      PasswordForgotEmailVM passwordForgotEmail);

  Future<Either<Failure, Map>> verifyCode(PasswordRecoveryVM passwordRecovery);

  Future<Either<Failure, Map>> recoverPassword(
      PasswordRecoveryVM passwordRecovery);
}
