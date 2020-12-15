import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/app_container/widgets/bottom_navigation_bar_widget.dart';
import 'package:party_mobile/app/pages/home/home_page.dart';
import 'package:party_mobile/app/pages/map/map_page.dart';
import 'package:party_mobile/app/pages/notifications/notifications_page.dart';
import 'package:party_mobile/app/pages/profile/profile_page.dart';
import 'package:party_mobile/app/pages/search/search_page.dart';

class AppContainer extends StatefulWidget {
  @override
  _AppContainerState createState() => _AppContainerState();
}

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

  // Widgets

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    MapPage(),
    NotificationsPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}
