import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:party_mobile/app/interfaces/profile_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/api_success_model.dart';
import 'package:party_mobile/app/models/profile_model.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';
import 'package:party_mobile/app/view_models/me_profile_vm.dart';

class ProfileRepository implements IProfileRepository {
  DioHttp _dio = locator<DioHttp>();

  @override
  Future<Either<Failure, ProfileModel>> getMe() async {
    try {
      var profile = await _dio.withAuth().get(Endpoints.profile);
      return Right(ProfileModel.fromJson(profile.data));
    } on DioError catch (e) {
      return Left(RequestError(message: e.response?.data['errors']));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessModel>> updateMe(
      MeProfileVM meProfile) async {
    try {
      var result = await _dio
          .withAuth()
          .put(Endpoints.profile, data: meProfile.getData());
      return Right(ApiSuccessModel.fromJson(result.data));
    } on DioError catch (e) {
      return Left(RequestError(message: e.response?.data['error'].join(', ')));
    }
  }

  @override
  Future<Either<Failure, Object>> followAccount(String uuid) async {
    try {
      var result =
          await _dio.withAuth().post("${Endpoints.accountFollow}/$uuid");
      return Right(result);
    } on DioError catch (e) {
      return Left(RequestError(message: e.response?.data['errors']));
    }
  }

  @override
  Future<Either<Failure, Object>> unfollowAccount(String uuid) async {
    try {
      var result =
          await _dio.withAuth().delete("${Endpoints.accountFollow}/$uuid");
      return Right(result);
    } on DioError catch (e) {
      return Left(RequestError(message: e.response?.data['errors']));
    }
  }
}
