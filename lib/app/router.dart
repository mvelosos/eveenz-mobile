import 'package:flutter/material.dart';

import 'package:party_mobile/app/pages/home/home_page.dart';
import 'package:party_mobile/app/pages/login/login_page.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart' as routes;

class Router {
  static Route<dynamic> generateRoute(RouteSettings route) {
    switch (route.name) {
      case routes.rootRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${route.name}'),
                  ),
                ));
    }
  }
}
