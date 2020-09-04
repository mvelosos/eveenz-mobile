import 'package:flutter/material.dart';
import 'package:party_mobile/app/pages/home_page.dart';

import 'package:party_mobile/app/pages/second_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings route) {
    switch (route.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/second':
        return MaterialPageRoute(builder: (_) => SecondPage());
    }
  }
}
