import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';

class Commons {
  static bool matchEmailRegex(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool matchUsernameRegex(username) {
    return RegExp(r"^[a-zA-Z0-9_.]+$").hasMatch(username);
  }

  static setAuthLocalStorage(AuthUserModel authUser) {
    var localStorage = locator<LocalStorageService>();
    localStorage.put(Storage.jwtToken, authUser.token);
    localStorage.put(Storage.username, authUser.username);
  }
}
