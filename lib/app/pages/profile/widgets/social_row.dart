import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/follows/follows_page.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/stores/me_store.dart';

class SocialRow extends StatelessWidget {
  NavigationService _navigationService;
  var _meStore = locator<MeStore>();

  @override
  Widget build(BuildContext context) {
    _navigationService = NavigationService.currentNavigator(context);

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Obx(
                  () => Text(
                    _meStore.events.value.toString(),
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('Eveenz'),
              ],
            ),
          ),
          SizedBox(width: 10),
          VerticalDivider(
            thickness: 1,
            color: AppColors.gray1,
            indent: 6,
            endIndent: 6,
          ),
          SizedBox(width: 10),
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
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('Seguidores'),
              ],
            ),
          ),
          SizedBox(width: 10),
          VerticalDivider(
            thickness: 1,
            color: AppColors.gray1,
            indent: 6,
            endIndent: 6,
          ),
          SizedBox(width: 10),
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
                    _meStore.followers.value.toString(),
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('Seguindo'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
