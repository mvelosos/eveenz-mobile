import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/repositories/profile_repository.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

class ProfileController {
  ProfileRepository _profileRepository;
  ProfileStore _profileStore;

  ProfileController() {
    _profileRepository = ProfileRepository();
    _profileStore = locator<ProfileStore>();
  }

  void getProfile() async {
    var profileResult = await _profileRepository.me();
    if (profileResult.isRight()) {
      _profileStore.setProfile(profileResult.getOrElse(null));
    }
  }
}
