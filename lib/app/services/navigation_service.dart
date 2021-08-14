import 'package:flutter/material.dart';
import 'package:party_mobile/app/router_manager.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationService(this.navigatorKey);

  static currentNavigator(BuildContext context) {
    var navigatorKey = ModalRoute.of(context)?.navigator?.widget.key
        as GlobalKey<NavigatorState>;
    return NavigationService(navigatorKey);
  }

  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedNoAnimation(String routeName) {
    MaterialPageRoute route =
        RouterManager.generateRoute(RouteSettings(name: routeName))
            as MaterialPageRoute;

    return navigatorKey.currentState!.push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => route.buildPage(
          navigatorKey.currentContext!,
          __,
          ___,
        ),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  Future<dynamic> pushReplacementNamedNoAnimation(String routeName) {
    MaterialPageRoute route =
        RouterManager.generateRoute(RouteSettings(name: routeName))
            as MaterialPageRoute;

    return navigatorKey.currentState!.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            route.buildPage(navigatorKey.currentContext!, __, ___),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
