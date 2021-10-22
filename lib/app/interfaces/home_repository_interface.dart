import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

abstract class IHomeRepository {
  Future<Either<Failure, dynamic>> getCards(double lat, double lon);
}
