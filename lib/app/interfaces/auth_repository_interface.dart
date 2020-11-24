import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

abstract class IAuthRepositoryInterface {
  Future<Either<Failure, AuthUserModel>> authLogin(
      {String login, String password});

  Future<Either<Failure, AuthUserModel>> authFacebook({String accessToken});
}
