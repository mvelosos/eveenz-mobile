import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/interfaces/auth_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';
import 'package:party_mobile/app/view_models/apple_login_vm.dart';
import 'package:party_mobile/app/view_models/facebook_login_vm.dart';
import 'package:party_mobile/app/view_models/google_login_vm.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';

class AuthRepository implements IAuthRepositoryInterface {
  DioHttp _dio;

  AuthRepository() {
    _dio = locator<DioHttp>();
  }

  @override
  Future<Either<Failure, AuthUserModel>> authLogin(
      UserLoginVM userLogin) async {
    try {
      var user = await _dio.instance
          .post(Endpoints.authLogin, data: userLogin.getData());
      return Right(AuthUserModel.fromJson(user.data));
    } catch (e) {
      return Left(LoginError(message: e.response.data['error']));
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> authFacebook(
      FacebookLoginVM fbLogin) async {
    try {
      var user = await _dio.instance
          .post(Endpoints.authFacebook, data: fbLogin.getData());

      return Right(AuthUserModel.fromJson(user.data));
    } catch (e) {
      return Left(LoginError(message: e.response.data['error']));
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> authGoogle(
      GoogleLoginVM googleLogin) async {
    try {
      var user = await _dio.instance
          .post(Endpoints.authGoogle, data: googleLogin.getData());

      return Right(AuthUserModel.fromJson(user.data));
    } catch (e) {
      return Left(LoginError(message: e.response.data['error']));
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> authApple(
      AppleLoginVM appleLogin) async {
    try {
      var user = await _dio.instance
          .post(Endpoints.authApple, data: appleLogin.getData());

      return Right(AuthUserModel.fromJson(user.data));
    } catch (e) {
      return Left(LoginError(message: e.response.data['error']));
    }
  }
}
