import 'package:get/get.dart';
import 'package:party_mobile/app/models/profile_model.dart';

class ProfileStore {
  RxString uuid = ''.obs;
  RxString username = ''.obs;
  RxString name = ''.obs;
  RxString bio = ''.obs;
  RxInt popularity = 0.obs;
  RxInt events = 0.obs;
  RxInt following = 0.obs;
  RxInt followers = 0.obs;
  RxString avatarUrl = ''.obs;
  RxMap accountSetting = {}.obs;
  RxDouble latitude = .0.obs;
  RxDouble longitude = .0.obs;

  void setMe(ProfileModel profileModel) {
    uuid.value = profileModel.account.uuid;
    username.value = profileModel.account.username;
    name.value = profileModel.account.name;
    bio.value = profileModel.account.bio ?? '';
    popularity.value = profileModel.account.popularity;
    events.value = profileModel.account.events;
    following.value = profileModel.account.following;
    followers.value = profileModel.account.followers;
    avatarUrl.value = profileModel.account.avatarUrl ?? '';
    accountSetting.value = profileModel.account.accountSetting.toJson();
  }

  void setLocalization(double lat, double lon) {
    latitude.value = lat;
    longitude.value = lon;
  }

  void clear() {
    uuid.value = '';
    username.value = '';
    name.value = '';
    bio.value = '';
    popularity.value = 0;
    events.value = 0;
    following.value = 0;
    followers.value = 0;
    avatarUrl.value = '';
    accountSetting.value = {};
  }
}
