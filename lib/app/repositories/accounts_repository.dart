import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/interfaces/accounts_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';

class AccountsRepository implements IAccountsRepository {
  DioHttp _dio;

  AccountsRepository() {
    _dio = locator<DioHttp>();
  }

  @override
  Future<Either<Failure, AccountModel>> getAccount(String username) async {
    try {
      var result = await _dio.withAuth().get("${Endpoints.accounts}/$username");
      return Right(AccountModel.fromJson(result.data['account']));
    } catch (e) {
      return Left(RequestError(message: e.response.data['errors']));
    }
  }

  @override
  Future<Either<Failure, Object>> getFollowers(String uuid) async {
    try {
      var url = Endpoints.accountFollowers.replaceAll(':uuid', uuid);
      var result = await _dio.withAuth().get(url);
      return Right(result.data);
    } catch (e) {
      return Left(RequestError(message: e.response.data['errors']));
    }
  }

  @override
  Future<Either<Failure, Object>> getFollowing(String uuid) async {
    try {
      var url = Endpoints.accountFollowing.replaceAll(':uuid', uuid);
      var result = await _dio.withAuth().get(url);
      return Right(result.data);
    } catch (e) {
      return Left(RequestError(message: e.response.data['errors']));
    }
  }
}
