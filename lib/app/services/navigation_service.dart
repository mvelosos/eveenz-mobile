import 'package:flutter/material.dart';
import 'package:party_mobile/app/router_manager.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedNoAnimation(String routeName) {
    MaterialPageRoute route =
        RouterManager.generateRoute(RouteSettings(name: routeName));

    return navigatorKey.currentState.push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            route.buildPage(navigatorKey.currentContext, null, null),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  Future<dynamic> pushNamedReplacementNoAnimation(String routeName) {
    MaterialPageRoute route =
        RouterManager.generateRoute(RouteSettings(name: routeName));

    return navigatorKey.currentState.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            route.buildPage(navigatorKey.currentContext, null, null),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
