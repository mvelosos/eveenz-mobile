import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/repositories/profile_repository.dart';
import 'package:party_mobile/app/stores/me_store.dart';

class MeController {
  MeRepository _profileRepository;
  MeStore _profileStore;

  MeController() {
    _profileRepository = MeRepository();
    _profileStore = locator<MeStore>();
  }

  Future<void> getMe() async {
    var profileResult = await _profileRepository.getMe();
    if (profileResult.isRight()) {
      _profileStore.setMe(profileResult.getOrElse(null));
    }
  }
}
