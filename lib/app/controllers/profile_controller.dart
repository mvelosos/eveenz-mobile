import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/repositories/profile_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/stores/profile_store.dart';
import 'package:party_mobile/app/view_models/me_profile_vm.dart';

class ProfileController {
  ProfileRepository _meRepository;
  ProfileStore _meStore;

  ProfileController() {
    _meRepository = ProfileRepository();
    _meStore = locator<ProfileStore>();
  }

  Future<void> getMe() async {
    var profileResult = await _meRepository.getMe();
    if (profileResult.isRight()) {
      _meStore.setMe(profileResult.getOrElse(null));
    }
  }

  void updateMe(MeProfileVM meProfile) async {
    await _meRepository.updateMe(meProfile);
  }

  Future<Either<Failure, Object>> followAccount(String uuid) async {
    var result = await _meRepository.followAccount(uuid);
    return result;
  }

  Future<Either<Failure, Object>> unfollowAccount(String uuid) async {
    var result = await _meRepository.unfollowAccount(uuid);
    return result;
  }
}
