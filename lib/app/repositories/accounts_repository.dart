import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:party_mobile/app/interfaces/accounts_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';
import 'package:party_mobile/app/view_models/search_vm.dart';

class AccountsRepository implements IAccountsRepository {
  DioHttp _dio = locator<DioHttp>();

  @override
  Future<Either<Failure, AccountModel>> getAccount(String username) async {
    try {
      var url = Endpoints.accountShow.replaceAll(':username', username);
      var result = await _dio.withAuth().get(url);
      return Right(AccountModel.fromJson(result.data['account']));
    } on DioError catch (e) {
      return Left(RequestError(message: e.response?.data['errors']));
    }
  }

  @override
  Future<Either<Failure, Object>> getFollowers(String username,
      [SearchVM? search]) async {
    try {
      var url = Endpoints.accountFollowers.replaceAll(':username', username);
      Map<String, dynamic> params = {};

      if (search != null && search.query.isNotEmpty) {
        params['query'] = search.query;
      }

      var result = await _dio.withAuth().get(url, queryParameters: params);
      return Right(result.data);
    } on DioError catch (e) {
      return Left(RequestError(message: e.response?.data['errors']));
    }
  }

  @override
  Future<Either<Failure, Object>> getFollowing(String username,
      [SearchVM? search]) async {
    try {
      var url = Endpoints.accountFollowing.replaceAll(':username', username);

      Map<String, dynamic> params = {};

      if (search != null && search.query.isNotEmpty) {
        params['query'] = search.query;
      }

      var result = await _dio.withAuth().get(url, queryParameters: params);
      return Right(result.data);
    } on DioError catch (e) {
      return Left(RequestError(message: e.response?.data['errors']));
    }
  }
}
