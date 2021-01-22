import 'package:party_mobile/app/repositories/users_repository.dart';

class UsersController {
  UsersRepository _usersRepository;

  UsersController() {
    _usersRepository = UsersRepository();
  }

  Future<bool> usernameAvailable(String username) async {
    var result = await _usersRepository.usernameAvailable(username);
    return result.getOrElse(null);
  }
}
