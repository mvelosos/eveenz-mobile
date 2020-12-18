import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/router_manager.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class SearchNavigator extends StatefulWidget {
  @override
  _SearchNavigatorState createState() => _SearchNavigatorState();
}

final _searchNavigatorKey = locator<SearchNavigatorKey>().navigatorKey;

class _SearchNavigatorState extends State<SearchNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _searchNavigatorKey,
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: RouteNames.search,
    );
  }
}
