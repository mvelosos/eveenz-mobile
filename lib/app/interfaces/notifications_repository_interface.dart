import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

abstract class INotificationsRepository {
  Future<Either<Failure, Map>> getNotifications();
}
