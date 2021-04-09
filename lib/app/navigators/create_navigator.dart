import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/router_manager.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class CreateNavigator extends StatefulWidget {
  @override
  _CreateNavigatorState createState() => _CreateNavigatorState();
}

final _notificationsNavigatorKey = locator<CreateNavigatorKey>().navigatorKey;

class _CreateNavigatorState extends State<CreateNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _notificationsNavigatorKey,
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: RouteNames.newEvent,
    );
  }
}
