import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/router_manager.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class NotificationsNavigator extends StatefulWidget {
  @override
  _NotificationsNavigatorState createState() => _NotificationsNavigatorState();
}

final _notificationsNavigatorKey =
    locator<NotificationsNavigatorKey>().navigatorKey;

class _NotificationsNavigatorState extends State<NotificationsNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _notificationsNavigatorKey,
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: RouteNames.notifications,
    );
  }
}
