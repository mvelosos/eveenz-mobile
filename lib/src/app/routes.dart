import 'package:flutter/material.dart';
import 'package:party_mobile/src/screens/home_screen.dart';

import 'package:party_mobile/src/screens/second_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings route) {
    switch (route.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/second':
        return MaterialPageRoute(builder: (_) => SecondScreen());
    }
  }
}
