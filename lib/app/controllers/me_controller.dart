import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/repositories/me_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';
import 'package:party_mobile/app/stores/me_store.dart';

class MeController {
  MeRepository _meRepository;
  MeStore _meStore;

  MeController() {
    _meRepository = MeRepository();
    _meStore = locator<MeStore>();
  }

  Future<void> getMe() async {
    var profileResult = await _meRepository.getMe();
    if (profileResult.isRight()) {
      _meStore.setMe(profileResult.getOrElse(null));
    }
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
