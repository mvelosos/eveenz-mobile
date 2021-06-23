import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:party_mobile/app/interfaces/notifications_repository_interface.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/endpoints.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/shared/utils/dio_http.dart';

class NotificationsRepository implements INotificationsRepository {
  DioHttp _dio = locator<DioHttp>();

  @override
  Future<Either<Failure, Map>> getNotifications() async {
    try {
      var result = await _dio.withAuth().get(Endpoints.notifications);
      return Right(result.data);
    } on DioError catch (e) {
      return Left(RequestError(message: e.response?.data['errors']));
    }
  }
}
