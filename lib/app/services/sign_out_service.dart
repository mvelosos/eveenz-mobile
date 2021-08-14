import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';
import 'package:party_mobile/app/stores/app_store.dart';
import 'package:party_mobile/app/stores/auth_user_store.dart';
import 'package:party_mobile/app/websocket.dart';

class SignOutService {
  static final LocalStorageService _storage = locator<LocalStorageService>();
  static final AuthUserStore _authUserStore = locator<AuthUserStore>();
  static final AppStore _appStore = locator<AppStore>();
  static final _navigationService =
      NavigationService(locator<RootNavigatorKey>().navigatorKey);

  static signOutUser() {
    _appStore.userAuthenticated.value = false;
    _storage.delete(Storage.jwtToken);
    _storage.delete(Storage.username);
    _authUserStore.clear();
    OneSignal.shared.removeExternalUserId();
    Websocket.finishConection();
    _navigationService.pushNamedAndRemoveUntil(RouteNames.root);
  }
}
