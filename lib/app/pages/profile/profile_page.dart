import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
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
  var _profileController = locator<ProfileController>();
  var _profileStore = locator<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) {
          return Text(_profileStore.username,
              style: TextStyle(color: Colors.blue));
        }),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return RefreshIndicator(
            color: Colors.blue,
            displacement: 0,
            onRefresh: () async {
              await _profileController.getProfile();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Observer(
                              builder: (_) => Text(
                                _profileStore.events.toString(),
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            Text('Festas'),
                          ],
                        ),
                        Column(
                          children: [
                            Observer(
                              builder: (_) => Text(
                                _profileStore.followers.toString(),
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            Text('Seguidores'),
                          ],
                        ),
                        Column(
                          children: [
                            Observer(
                              builder: (_) => Text(
                                _profileStore.following.toString(),
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            Text('Seguindo'),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Observer(
                            builder: (_) {
                              return _profileStore.avatarUrl != ''
                                  ? Image.network(
                                      _profileStore.avatarUrl,
                                      height: 85,
                                      width: 85,
                                    )
                                  : CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Color(0xffd3d5db),
                                    );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
