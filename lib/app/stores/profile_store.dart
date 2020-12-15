import 'package:mobx/mobx.dart';
import 'package:party_mobile/app/models/profile_model.dart';
part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
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
  void setProfile(ProfileModel profileModel) {
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
