import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/interfaces/passwords_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';
import 'package:party_mobile/app/view_models/password_forgot_email_vm.dart';
import 'package:party_mobile/app/view_models/password_recovery_vm.dart';

class PasswordsRepository implements IPasswordsRepository {
  DioHttp _dio;

  PasswordsRepository() {
    _dio = locator<DioHttp>();
  }

  @override
  Future<Either<Failure, Map>> forgotPassword(
      PasswordForgotEmailVM passwordForgotEmail) async {
    try {
      var result = await _dio.instance
          .post(Endpoints.passwordsForgot, data: passwordForgotEmail.getData());
      return Right(result.data);
    } catch (e) {
      return Left(RequestError(message: e.response.data['error']));
    }
  }

  @override
  Future<Either<Failure, Map>> verifyCode(
      PasswordRecoveryVM passwordRecovery) async {
    try {
      var result = await _dio.instance.post(Endpoints.passwordsVerifyCode,
          data: passwordRecovery.getData());
      return Right(result.data);
    } catch (e) {
      return Left(RequestError(message: e.response.data['error']));
    }
  }

  @override
  Future<Either<Failure, Map>> recoverPassword(
      PasswordRecoveryVM passwordRecovery) async {
    try {
      var result = await _dio.instance
          .post(Endpoints.passwordsRecover, data: passwordRecovery.getData());
      return Right(result.data);
    } catch (e) {
      return Left(RequestError(message: e.response.data['error']));
    }
  }
}
