import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/interfaces/users_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';
import 'package:party_mobile/app/view_models/create_user_vm.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';

class UsersRepository implements IUsersRepository {
  DioHttp _dio;

  UsersRepository() {
    _dio = locator<DioHttp>();
  }

  @override
  Future<Either<Failure, AuthUserModel>> createUser(
      CreateUserVM createUser) async {
    try {
      var user =
          await _dio.instance.post(Endpoints.users, data: createUser.getData());
      return Right(AuthUserModel.fromJson(user.data));
    } catch (e) {
      if (e.response.data['errors'].length > 0) {
        var errors = e.response.data['errors'].join(', ');
        return Left(CreateUserError(message: errors));
      }
      return Left(CreateUserError(message: 'Unexpected error!'));
    }
  }

  @override
  Future<Either<Failure, bool>> usernameAvailable(String username) async {
    try {
      var result = await _dio.instance
          .get("${Endpoints.usernameAvailable}?username=$username");
      return Right(result.data['available']);
    } catch (e) {
      return Left(RequestError(message: 'Unexpected error!'));
    }
  }
}
