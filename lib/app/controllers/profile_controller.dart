import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/profile_model.dart';
import 'package:party_mobile/app/repositories/profile_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/stores/app_store.dart';
import 'package:party_mobile/app/stores/profile_store.dart';
import 'package:party_mobile/app/view_models/me_profile_vm.dart';

class ProfileController {
  ProfileRepository _profileRepository = ProfileRepository();
  ProfileStore _profileStore = locator<ProfileStore>();
  AppStore _appStore = locator<AppStore>();

  Future<void> getProfile() async {
    var profileResult = await _profileRepository.getMe();
    if (profileResult.isRight()) {
      _profileStore.setMe(profileResult.getOrElse(() => {} as ProfileModel));
      _appStore.userAuthenticated.value = true;
    }
  }

  Future<Either<Failure, dynamic>> updateProfile(MeProfileVM meProfile) async {
    var result = await _profileRepository.updateMe(meProfile);
    return result;
  }

  Future<Either<Failure, Object>> followAccount(String uuid) async {
    var result = await _profileRepository.followAccount(uuid);
    return result;
  }

  Future<Either<Failure, Object>> unfollowAccount(String uuid) async {
    var result = await _profileRepository.unfollowAccount(uuid);
    return result;
  }

  Future<Either<Failure, Object>> updateRequestFollows(
      String uuid, bool accepted) async {
    var result = await _profileRepository.updateRequestFollows(uuid, accepted);
    return result;
  }

  Future<Either<Failure, Object>> deleteRequestFollows(String uuid) async {
    var result = await _profileRepository.deleteRequestFollows(uuid);
    return result;
  }
}
