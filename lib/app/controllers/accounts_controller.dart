import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/repositories/accounts_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

class AccountsController {
  AccountsRepository _accountsRepository;

  AccountsController() {
    _accountsRepository = AccountsRepository();
  }

  Future<Either<Failure, AccountModel>> getAccount(String username) async {
    var accountResult = await _accountsRepository.getAccount(username);
    return accountResult;
  }
}
