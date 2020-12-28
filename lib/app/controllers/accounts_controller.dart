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

  Future<Either<Failure, List<AccountModel>>> getFollowers(
      String username) async {
    List<AccountModel> accountsList = [];
    var result = await _accountsRepository.getFollowers(username);
    if (result.isRight()) {
      dynamic resultList = result.getOrElse(null);
      if (resultList['accounts'] != null || resultList['accounts'] != []) {
        resultList['accounts'].forEach(
          (account) => accountsList.add(
            AccountModel.fromJson(account),
          ),
        );
      }
    }
    return Right(accountsList);
  }

  Future<Either<Failure, List<AccountModel>>> getFollowing(
      String username) async {
    List<AccountModel> accountsList = [];
    var result = await _accountsRepository.getFollowing(username);
    if (result.isRight()) {
      dynamic resultList = result.getOrElse(null);
      if (resultList['accounts'] != null || resultList['accounts'] != []) {
        resultList['accounts'].forEach(
          (account) => accountsList.add(
            AccountModel.fromJson(account),
          ),
        );
      }
    }
    return Right(accountsList);
  }
}
