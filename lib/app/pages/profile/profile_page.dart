import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TODO: Remove this from here \/
  var _storage = locator<LocalStorageService>();
  var _navigation = locator<NavigationService>();
  var _profileStore = locator<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Observer(
            builder: (_) => Text(_profileStore.username),
          ),
          Observer(
            builder: (_) => Text(_profileStore.name),
          ),
          RaisedButton(
            child: Text('Logout'),
            onPressed: () => {
              _storage.clear().then(
                    (_) => _navigation
                        .pushNamedReplacementNoAnimation(RouteNames.login),
                  )
            },
          ),
        ]),
      ),
    );
  }
}
