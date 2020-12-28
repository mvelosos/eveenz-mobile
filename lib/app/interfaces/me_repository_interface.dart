import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/profile_model.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

abstract class IMeRepository {
  Future<Either<Failure, ProfileModel>> getMe();

  Future<Either<Failure, Object>> followAccount(String uuid);

  Future<Either<Failure, Object>> unfollowAccount(String uuid);
}
