import 'package:flutter/material.dart';
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
  int _currentIndex = 0;

  final List<Widget> _telas = [
    HomePage(),
    SearchPage(),
    MapPage(),
    NotificationsPage(),
    ProfilePage()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: _telas[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: 'Map', icon: Icon(Icons.map)),
          BottomNavigationBarItem(label: 'List', icon: Icon(Icons.view_list)),
          BottomNavigationBarItem(label: 'U', icon: Icon(Icons.account_circle))
        ],
      ),
    );
  }
}
