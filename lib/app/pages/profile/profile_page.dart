import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_mobile/app/controllers/me_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/follows/follows_page.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/stores/me_store.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _meController = locator<MeController>();
  var _meStore = locator<MeStore>();

  @override
  Widget build(BuildContext context) {
    final _navigationService = NavigationService.currentNavigator(context);

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            _meStore.username.value,
            style: TextStyle(color: Colors.blue),
          ),
        ),
        centerTitle: true,
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
              await _meController.getMe();
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
                            Obx(
                              () => Text(
                                _meStore.events.value.toString(),
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            Text('Festas'),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _navigationService.pushNamed(
                              RouteNames.accountFollows,
                              arguments: FollowsPageArguments(
                                username: _meStore.username.value,
                                initialIndex: 0,
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Obx(
                                () => Text(
                                  _meStore.followers.value.toString(),
                                  style: TextStyle(fontSize: 19),
                                ),
                              ),
                              Text('Seguidores'),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _navigationService.pushNamed(
                              RouteNames.accountFollows,
                              arguments: FollowsPageArguments(
                                username: _meStore.username.value,
                                initialIndex: 1,
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Obx(
                                () => Text(
                                  _meStore.following.value.toString(),
                                  style: TextStyle(fontSize: 19),
                                ),
                              ),
                              Text('Seguindo'),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Obx(
                            () {
                              return _meStore.avatarUrl.value != ''
                                  ? Image.network(
                                      _meStore.avatarUrl.value,
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
                    ),
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
