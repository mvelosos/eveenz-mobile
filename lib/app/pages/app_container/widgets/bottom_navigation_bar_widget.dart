import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  BottomNavigationBarWidget({
    required this.currentIndex,
    required this.onTabTapped,
  });

  List<BottomNavigationBarItem> _barItems() {
    return [
      BottomNavigationBarItem(
        label: 'Home',
        icon: FaIcon(
          FontAwesomeIcons.home,
          size: 20,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Search',
        icon: FaIcon(
          FontAwesomeIcons.search,
          size: 20,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Map',
        icon: FaIcon(
          FontAwesomeIcons.map,
          size: 20,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Create',
        icon: FaIcon(
          FontAwesomeIcons.solidBell,
          size: 20,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Profile',
        icon: FaIcon(
          FontAwesomeIcons.solidUser,
          size: 20,
        ),
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
      selectedItemColor: AppColors.darkPurple,
    );
  }
}
