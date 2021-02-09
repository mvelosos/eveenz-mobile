import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/router_manager.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eveenz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: locator<RootNavigatorKey>().navigatorKey,
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: RouteNames.root,
    );
  }
}
