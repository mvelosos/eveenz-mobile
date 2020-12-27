import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/interfaces/me_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/profile_model.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';

class MeRepository implements IMeRepository {
  DioHttp _dio;

  MeRepository() {
    _dio = locator<DioHttp>();
  }

  @override
  Future<Either<Failure, ProfileModel>> getMe() async {
    try {
      var profile = await _dio.withAuth().get(Endpoints.me);
      return Right(ProfileModel.fromJson(profile.data));
    } catch (e) {
      return Left(RequestError(message: e.response.data['errors']));
    }
  }
}
