import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  BottomNavigationBarWidget(
      {@required this.currentIndex, @required this.onTabTapped});

  List<BottomNavigationBarItem> _barItems() {
    return [
      BottomNavigationBarItem(
        label: 'Home',
        icon: Icon(Icons.home),
      ),
      BottomNavigationBarItem(
        label: 'Search',
        icon: Icon(Icons.search),
      ),
      BottomNavigationBarItem(
        label: 'Map',
        icon: Icon(Icons.map),
      ),
      BottomNavigationBarItem(
        label: 'Notifications',
        icon: Icon(Icons.view_list),
      ),
      BottomNavigationBarItem(
        label: 'Profile',
        icon: Icon(Icons.account_circle),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (idx) => onTabTapped(idx),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: _barItems(),
    );
  }
}
