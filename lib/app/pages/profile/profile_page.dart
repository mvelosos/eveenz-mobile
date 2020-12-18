import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _navigationService =
      NavigationService(locator<ProfileNavigatorKey>().navigatorKey);
  var _profileStore = locator<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.view_headline),
            color: Colors.grey,
            tooltip: 'Show Snackbar',
            onPressed: () {
              _navigationService.pushNamed(RouteNames.settings);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Observer(
            builder: (_) => Text(_profileStore.username),
          ),
          Observer(
            builder: (_) => Text(_profileStore.name),
          ),
        ]),
      ),
    );
  }
}
