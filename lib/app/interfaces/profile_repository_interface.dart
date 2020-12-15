import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/profile_model.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

abstract class IProfileRepository {
  Future<Either<Failure, ProfileModel>> me();
}
