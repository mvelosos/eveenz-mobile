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
      return Right(AccountModel.fromJson(result.data));
    } catch (e) {
      return Left(RequestError(message: e.response.data['errors']));
    }
  }
}
