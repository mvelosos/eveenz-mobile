import 'package:mobx/mobx.dart';
import 'package:party_mobile/app/models/profile_model.dart';
part 'me_store.g.dart';

class MeStore = _MeStoreBase with _$MeStore;

abstract class _MeStoreBase with Store {
  @observable
  String uuid = '';

  @observable
  String username = '';

  @observable
  String name = '';

  @observable
  String bio = '';

  @observable
  int popularity = 0;

  @observable
  int events = 0;

  @observable
  int following = 0;

  @observable
  int followers = 0;

  @observable
  String avatarUrl = '';

  @action
  void setMe(ProfileModel profileModel) {
    uuid = profileModel.account.uuid ?? '';
    username = profileModel.account.username ?? '';
    name = profileModel.account.name ?? '';
    bio = profileModel.account.bio ?? '';
    popularity = profileModel.account.popularity ?? '';
    events = profileModel.account.events ?? '';
    following = profileModel.account.following ?? '';
    followers = profileModel.account.followers ?? '';
    avatarUrl = profileModel.account.avatarUrl ?? '';
  }
}
