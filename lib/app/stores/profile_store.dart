import 'package:mobx/mobx.dart';
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
  void setProfile() {}
}
