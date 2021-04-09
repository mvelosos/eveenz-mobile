import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:party_mobile/app/controllers/me_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/home_navigator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/navigators/map_navigator.dart';
import 'package:party_mobile/app/navigators/create_navigator.dart';
import 'package:party_mobile/app/navigators/profile_navigator.dart';
import 'package:party_mobile/app/navigators/search_navigator.dart';
import 'package:party_mobile/app/pages/app_container/widgets/bottom_navigation_bar_widget.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/stores/me_store.dart';

class AppContainer extends StatefulWidget {
  @override
  _AppContainerState createState() => _AppContainerState();
}

final _homeNavigatorKey = locator<HomeNavigatorKey>().navigatorKey;
final _searchNavigatorKey = locator<SearchNavigatorKey>().navigatorKey;
final _mapNavigatorKey = locator<MapNavigatorKey>().navigatorKey;
final _createNavigatorKey = locator<CreateNavigatorKey>().navigatorKey;
final _profileNavigatorKey = locator<ProfileNavigatorKey>().navigatorKey;
final _meStore = locator<MeStore>();

class _AppContainerState extends State<AppContainer> {
  var _profileController = locator<MeController>();
  int _currentIndex = 0;

  // Functions

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  void _initUser() async {
    await _profileController.getMe();
    _setOneSignalSubscription();
  }

  void _setOneSignalSubscription() async {
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    OneSignal.shared.setExternalUserId(_meStore.uuid.value);
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) {
      NavigatorState navigator = _navigatorKeys[_currentIndex].currentState;
      navigator.popUntil(
        (route) => route.settings.name == navigator.widget.initialRoute,
      );
    }
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _systemBackButtonPressed() async {
    NavigatorState navigator = _navigatorKeys[_currentIndex].currentState;

    if (navigator == null) return Future.value(false);

    List<String> routeNames = [
      RouteNames.home,
      RouteNames.search,
      RouteNames.map,
      RouteNames.newEvent,
      RouteNames.profile
    ];
    // SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');

    navigator.popUntil(
      (route) => routeNames.contains(route.settings.name) ? null : null,
    );

    return Future.value();
  }

  // Widgets

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    _homeNavigatorKey,
    _searchNavigatorKey,
    _mapNavigatorKey,
    _createNavigatorKey,
    _profileNavigatorKey
  ];

  final List<Widget> _navigators = [
    HomeNavigator(),
    SearchNavigator(),
    MapNavigator(),
    CreateNavigator(),
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
