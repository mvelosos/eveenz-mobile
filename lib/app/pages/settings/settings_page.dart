import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/stores/auth_user_store.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AuthUserStore _authUserStore = locator<AuthUserStore>();
  var _storage = locator<LocalStorageService>();
  var _navigationService =
      NavigationService(locator<RootNavigatorKey>().navigatorKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Logout'),
              onPressed: () => {
                _storage.clear().then(
                      (_) => {
                        _authUserStore.clean(),
                        OneSignal.shared.removeExternalUserId(),
                        _navigationService
                            .pushReplacementNamedNoAnimation(RouteNames.login)
                      },
                    )
              },
            ),
          ],
        ),
      ),
    );
  }
}
