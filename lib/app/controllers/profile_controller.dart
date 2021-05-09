import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/repositories/profile_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/stores/profile_store.dart';
import 'package:party_mobile/app/view_models/me_profile_vm.dart';

class ProfileController {
  ProfileRepository _profileRepository;
  ProfileStore _profileStore;

  ProfileController() {
    _profileRepository = ProfileRepository();
    _profileStore = locator<ProfileStore>();
  }

  Future<void> getProfile() async {
    var profileResult = await _profileRepository.getMe();
    if (profileResult.isRight()) {
      _profileStore.setMe(profileResult.getOrElse(null));
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
}
