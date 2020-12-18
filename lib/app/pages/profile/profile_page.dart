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
    return LayoutBuilder(
      builder: (context, constraints) {
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
            body: RefreshIndicator(
              color: Colors.blue,
              displacement: 0,
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2), () => true);
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Column(children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image(
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ));
      },
    );
  }
}
