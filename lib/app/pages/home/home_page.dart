import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/pages/account/account_page.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _homeNavigator =
      NavigationService(locator<HomeNavigatorKey>().navigatorKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.blue),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            _homeNavigator.pushNamed(
              RouteNames.showAccount,
              arguments: AccountPageArguments(username: 'test'),
            );
          },
          child: Text('Tela de usuário'),
        ),
      ),
    );
  }
}
