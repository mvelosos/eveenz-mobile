import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var _navigationService =
      NavigationService(locator<RootNavigatorKey>().navigatorKey);

  @override
  void initState() {
    super.initState();
    _setInitialRoute();
  }

  _setInitialRoute() async {
    var localStorage = locator<LocalStorageService>();
    localStorage.get(Storage.jwtToken).then((value) => {
          if (value != null)
            _navigationService
                .pushReplacementNamedNoAnimation(RouteNames.appContainer)
          else
            _navigationService.pushReplacementNamedNoAnimation(RouteNames.login)
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
