import 'package:flutter/material.dart';
import 'package:party_mobile/app/pages/app_container/app_container.dart';
import 'package:party_mobile/app/pages/home/home_page.dart';
import 'package:party_mobile/app/pages/login/login_page.dart';
import 'package:party_mobile/app/pages/root/root_page.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings route) {
    switch (route.name) {
      case RouteNames.root:
        return MaterialPageRoute(builder: (_) => RootPage());

      case RouteNames.appContainer:
        return MaterialPageRoute(builder: (_) => AppContainer());

      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomePage());

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
}
