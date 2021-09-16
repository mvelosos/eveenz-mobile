import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/account_follow_model.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/repositories/accounts_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/search_vm.dart';

class AccountsController {
  AccountsRepository _accountsRepository = AccountsRepository();

  Future<Either<Failure, AccountModel>> getAccount(String username) async {
    var accountResult = await _accountsRepository.getAccount(username);
    return accountResult;
  }

  Future<Either<Failure, List<AccountFollowModel>>> getFollowers(
      String username,
      [SearchVM? search]) async {
    List<AccountFollowModel> accountsList = [];
    var result = await _accountsRepository.getFollowers(username, search);
    if (result.isRight()) {
      dynamic resultList = result.getOrElse(() => {});
      if (resultList['accounts'] != null || resultList['accounts'] != []) {
        resultList['accounts'].forEach(
          (account) => accountsList.add(
            AccountFollowModel.fromJson(account),
          ),
        );
      }
    }
    return Right(accountsList);
  }

  Future<Either<Failure, List<AccountFollowModel>>> getFollowing(
      String username, SearchVM? search) async {
    List<AccountFollowModel> accountsList = [];
    var result = await _accountsRepository.getFollowing(username, search);
    if (result.isRight()) {
      dynamic resultList = result.getOrElse(() => {});
      if (resultList['accounts'] != null || resultList['accounts'] != []) {
        resultList['accounts'].forEach(
          (account) => accountsList.add(
            AccountFollowModel.fromJson(account),
          ),
        );
      }
    }
    return Right(accountsList);
  }
}
