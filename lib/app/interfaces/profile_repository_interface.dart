import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/api_success_model.dart';
import 'package:party_mobile/app/models/profile_model.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/view_models/me_profile_vm.dart';

abstract class IProfileRepository {
  Future<Either<Failure, ProfileModel>> getMe();

  Future<Either<Failure, ApiSuccessModel>> updateMe(MeProfileVM meProfile);

  Future<Either<Failure, Object>> followAccount(String uuid);

  Future<Either<Failure, Object>> unfollowAccount(String uuid);
}
