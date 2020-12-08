import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    _setInitialRoute();
  }

  _setInitialRoute() async {
    var localStorage = locator<LocalStorageService>();
    localStorage.get(Storage.jwtToken).then((value) => {
          if (value != null)
            {
              locator<NavigationService>()
                  .pushNamedReplacementNoAnimation(RouteNames.appContainer)
            }
          else
            {
              locator<NavigationService>()
                  .pushReplacementNamed(RouteNames.login)
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
