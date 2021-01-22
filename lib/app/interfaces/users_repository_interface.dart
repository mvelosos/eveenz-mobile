import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/create_user_vm.dart';

abstract class IUsersRepository {
  Future<Either<Failure, AuthUserModel>> createUser(CreateUserVM createUser);

  Future<Either<Failure, bool>> usernameAvailable(String username);
}
