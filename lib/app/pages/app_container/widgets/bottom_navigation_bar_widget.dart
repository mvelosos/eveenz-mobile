import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/stores/notifications_store.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final NotificationsStore _notificationsStore = locator<NotificationsStore>();

  BottomNavigationBarWidget({
    required this.currentIndex,
    required this.onTabTapped,
  });

  BottomNavigationBarItem _bottomNavigationBarItem(String label, Widget icon) {
    return BottomNavigationBarItem(
      label: label,
      icon: icon,
    );
  }

  BottomNavigationBarItem _notifiableBottomNavigationBarItem(
      String label, Widget icon) {
    return BottomNavigationBarItem(
      icon: Stack(
        children: <Widget>[
          icon,
          Obx(
            () => _notificationsStore.showNotificationBadge.value
                ? Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          )
        ],
      ),
      label: label,
    );
  }

  List<BottomNavigationBarItem> _barItems() {
    return [
      _bottomNavigationBarItem(
        'Home',
        FaIcon(
          FontAwesomeIcons.home,
          size: 20,
        ),
      ),
      _bottomNavigationBarItem(
        'Search',
        FaIcon(
          FontAwesomeIcons.search,
          size: 20,
        ),
      ),
      _bottomNavigationBarItem(
        'Map',
        FaIcon(
          FontAwesomeIcons.globeAmericas,
          size: 20,
        ),
      ),
      _notifiableBottomNavigationBarItem(
        'Notifications',
        Icon(Icons.notifications),
      ),
      _bottomNavigationBarItem(
        'Profile',
        FaIcon(
          FontAwesomeIcons.solidUser,
          size: 20,
        ),
      ),
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
