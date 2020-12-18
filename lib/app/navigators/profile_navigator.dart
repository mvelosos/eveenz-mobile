import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/router_manager.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class ProfileNavigator extends StatefulWidget {
  @override
  _ProfileNavigatorState createState() => _ProfileNavigatorState();
}

final _profileNavigatorKey = locator<ProfileNavigatorKey>().navigatorKey;

class _ProfileNavigatorState extends State<ProfileNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _profileNavigatorKey,
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: RouteNames.profile,
    );
  }
}
