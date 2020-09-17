import 'package:flutter/material.dart';

import 'package:party_mobile/app/pages/login/login_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings route) {
    switch (route.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
