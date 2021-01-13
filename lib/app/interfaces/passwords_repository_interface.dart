import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/password_forgot_email_vm.dart';

abstract class IPasswordsRepository {
  Future<Either<Failure, Map>> forgotPassword(
      PasswordForgotEmailVM passwordForgotEmail);
}
