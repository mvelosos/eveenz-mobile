import 'package:get/get.dart';
import 'package:party_mobile/app/models/profile_model.dart';

class MeStore {
  RxString uuid = ''.obs;
  RxString username = ''.obs;
  RxString name = ''.obs;
  RxString bio = ''.obs;
  RxInt popularity = 0.obs;
  RxInt events = 0.obs;
  RxInt following = 0.obs;
  RxInt followers = 0.obs;
  RxString avatarUrl = ''.obs;

  String get atUsername => username.value != '' ? '@${username.value}' : '';

  void setMe(ProfileModel profileModel) {
    uuid.value = profileModel.account.uuid ?? '';
    username.value = profileModel.account.username ?? '';
    name.value = profileModel.account.name ?? '';
    bio.value = profileModel.account.bio ?? '';
    popularity.value = profileModel.account.popularity ?? '';
    events.value = profileModel.account.events ?? '';
    following.value = profileModel.account.following ?? '';
    followers.value = profileModel.account.followers ?? '';
    avatarUrl.value = profileModel.account.avatarUrl ?? '';
  }
}
