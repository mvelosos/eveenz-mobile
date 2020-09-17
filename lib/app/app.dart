import 'package:flutter/material.dart';

import 'package:party_mobile/app/router.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart' as routes;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Party Project',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: routes.rootRoute,
      onGenerateRoute: Router.generateRoute,
    );
  }
}
