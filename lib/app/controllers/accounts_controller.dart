import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/repositories/accounts_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

class AccountsController {
  AccountsRepository _usersRepository;

  AccountsController() {
    _usersRepository = AccountsRepository();
  }

  Future<Either<Failure, AccountModel>> getUser(String username) async {
    var userResult = await _usersRepository.getUser(username);
    return userResult;
  }
}
