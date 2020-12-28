import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

abstract class IAccountsRepository {
  Future<Either<Failure, AccountModel>> getAccount(String username);

  Future<Either<Failure, Object>> getFollowers(String uuid);

  Future<Either<Failure, Object>> getFollowing(String uuid);
}
