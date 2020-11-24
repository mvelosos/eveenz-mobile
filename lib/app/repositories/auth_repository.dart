import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:party_mobile/app/interfaces/auth_repository_interface.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';

import '../locator.dart';

class AuthRepository implements IAuthRepositoryInterface {
  DioHttp dio = locator<DioHttp>();

  @override
  Future<Either<Failure, AuthUserModel>> authLogin(
      {String login, String password}) async {
    try {
      Map<String, Map<String, String>> request = {
        "user": {"login": login, "password": password}
      };
      var user = await dio.instance.post(Endpoints.authLogin, data: request);
      print(user);
      // return Right(user);
    } catch (e) {
      print(e.response);
      return Left(ErrorLogin(message: "Error login with Email"));
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> authFacebook({String accessToken}) {
    // TODO: implement authFacebook
    throw UnimplementedError();
  }
}
