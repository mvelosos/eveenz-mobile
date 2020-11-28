import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';

import 'package:party_mobile/app/pages/home/home_page.dart';
import 'package:party_mobile/app/pages/login/login_page.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings route) {
    switch (route.name) {
      case RouteNames.root:
        // TODO: Make this work!
        print(_setInitialRoute());
        return MaterialPageRoute(builder: (_) => LoginPage());

      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${route.name}'),
            ),
          ),
        );
    }
  }

  static _setInitialRoute() async {
    var route;
    var localStorage = locator<LocalStorageService>();
    localStorage.get('party@jwt_token').then((value) => {print(value)});
    return route;
  }
}
