import 'package:get/get.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';

class AuthUserStore {
  RxString token = ''.obs;
  RxString tokenType = ''.obs;
  RxString exp = ''.obs;
  RxString provider = ''.obs;

  void setUser(AuthUserModel authUser) {
    token.value = authUser.token;
    tokenType.value = authUser.tokenType;
    exp.value = authUser.exp;
    provider.value = authUser.provider;
  }

  void clear() {
    token.value = '';
    tokenType.value = '';
    exp.value = '';
    provider.value = '';
  }
}
