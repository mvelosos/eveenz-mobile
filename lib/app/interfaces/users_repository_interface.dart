import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/user_model.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

abstract class IUsersRepository {
  Future<Either<Failure, UserModel>> getUser(String username);
}
