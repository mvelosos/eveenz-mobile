import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/user_model.dart';
import 'package:party_mobile/app/repositories/users_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

class UsersController {
  UsersRepository _usersRepository;

  UsersController() {
    _usersRepository = UsersRepository();
  }

  Future<Either<Failure, UserModel>> getUser(String username) async {
    var userResult = await _usersRepository.getUser(username);
    return userResult;
  }
}
