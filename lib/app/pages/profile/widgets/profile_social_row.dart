import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/follows/follows_page.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/stores/me_store.dart';

class ProfileSocialRow extends StatelessWidget {
  final _navigationService;
  final MeStore _meStore = locator<MeStore>();

  ProfileSocialRow(this._navigationService);

  String _formattedSocialValue(int value) {
    var strValue = value.toString();
    var formattedValue = value.toString();

    if (strValue.length == 5) {
      formattedValue = '${strValue[0]}${strValue[1]},${strValue[2]} mil';
    }

    if (strValue.length == 6) {
      formattedValue = '${strValue[0]}${strValue[1]}${strValue[2]} mil';
    }

    if (strValue.length == 7) {
      formattedValue = '${strValue[0]},${strValue[1]}M';
    }

    if (strValue.length == 8) {
      formattedValue = '${strValue[0]}${strValue[1]},${strValue[2]}M';
    }

    if (strValue.length == 9) {
      formattedValue = '${strValue[0]}${strValue[1]}${strValue[2]}M';
    }

    return formattedValue;
  }

  @override
  Widget build(BuildContext context) {
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
                    _formattedSocialValue(_meStore.followers.value),
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
                    _formattedSocialValue(_meStore.following.value),
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
