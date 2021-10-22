import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:party_mobile/app/interfaces/home_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';

class HomeRepository implements IHomeRepository {
  DioHttp _dio = locator<DioHttp>();

  @override
  Future<Either<Failure, dynamic>> getCards(double lat, double lon) async {
    try {
      var params = {
        'localization': {'lat': lat, 'lon': lon}
      };

      var result = await _dio.instance
          .get('${Endpoints.home}/cards', queryParameters: params);
      return Right(result.data);
    } on DioError catch (e) {
      return Left(RequestError(message: e.error));
    }
  }
}
