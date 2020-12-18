import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/router_manager.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class MapNavigator extends StatefulWidget {
  @override
  _MapNavigatorState createState() => _MapNavigatorState();
}

final _mapNavigatorKey = locator<MapNavigatorKey>().navigatorKey;

class _MapNavigatorState extends State<MapNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _mapNavigatorKey,
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: RouteNames.map,
    );
  }
}
