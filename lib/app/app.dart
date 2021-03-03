import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/router_manager.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:device_preview/device_preview.dart';

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
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
