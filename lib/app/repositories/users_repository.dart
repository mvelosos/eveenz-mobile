import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/interfaces/users_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/models/user_model.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';

class UsersRepository implements IUsersRepository {
  DioHttp _dio;

  UsersRepository() {
    _dio = locator<DioHttp>();
  }

  @override
  Future<Either<Failure, UserModel>> getUser(String username) async {
    try {
      var result = await _dio.withAuth().get("${Endpoints.users}/$username");
      return Right(UserModel.fromJson(result.data));
    } catch (e) {
      return Left(RequestError(message: e.response.data['errors']));
    }
  }
}
