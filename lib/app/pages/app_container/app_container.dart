import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/home_navigator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/navigators/map_navigator.dart';
import 'package:party_mobile/app/navigators/notifications_navigator.dart';
import 'package:party_mobile/app/navigators/profile_navigator.dart';
import 'package:party_mobile/app/navigators/search_navigator.dart';
import 'package:party_mobile/app/pages/app_container/widgets/bottom_navigation_bar_widget.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class AppContainer extends StatefulWidget {
  @override
  _AppContainerState createState() => _AppContainerState();
}

final _homeNavigatorKey = locator<HomeNavigatorKey>().navigatorKey;
final _searchNavigatorKey = locator<SearchNavigatorKey>().navigatorKey;
final _mapNavigatorKey = locator<MapNavigatorKey>().navigatorKey;
final _notificationsNavigatorKey =
    locator<NotificationsNavigatorKey>().navigatorKey;
final _profileNavigatorKey = locator<ProfileNavigatorKey>().navigatorKey;

class _AppContainerState extends State<AppContainer> {
  var _profileController = locator<ProfileController>();
  int _currentIndex = 0;

  // Functions

  @override
  void initState() {
    super.initState();
    _profileController.getProfile();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _systemBackButtonPressed() async {
    final NavigatorState navigator = _navigatorKeys[_currentIndex].currentState;
    // SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');

    if (navigator == null) return false;
    navigator.popUntil((route) {
      switch (route.settings.name) {
        case RouteNames.home:
          return true;
        case RouteNames.search:
          return true;
        case RouteNames.map:
          return true;
        case RouteNames.notifications:
          return true;
        case RouteNames.profile:
          return true;
        default:
          return false;
      }
    });
  }

  // Widgets

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    _homeNavigatorKey,
    _searchNavigatorKey,
    _mapNavigatorKey,
    _notificationsNavigatorKey,
    _profileNavigatorKey
  ];

  final List<Widget> _navigators = [
    HomeNavigator(),
    SearchNavigator(),
    MapNavigator(),
    NotificationsNavigator(),
    ProfileNavigator()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _navigators,
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          currentIndex: _currentIndex,
          onTabTapped: _onTabTapped,
        ),
      ),
    );
  }
}
