import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/router_manager.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

final _homeNavigatorKey = locator<HomeNavigatorKey>().navigatorKey;

class _HomeNavigatorState extends State<HomeNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _homeNavigatorKey,
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: RouteNames.home,
    );
  }
}
