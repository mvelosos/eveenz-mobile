import 'package:flutter/material.dart';
import 'package:party_mobile/app/pages/follows/follows_page.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class ProfileSocialRow extends StatelessWidget {
  final BuildContext context;
  final String username;
  final int eventsCount;
  final int followersCount;
  final int followingCount;

  ProfileSocialRow({
    required this.context,
    required this.username,
    required this.eventsCount,
    required this.followersCount,
    required this.followingCount,
  });

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
                Text(
                  eventsCount.toString(),
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
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
              Navigator.of(context).pushNamed(
                RouteNames.accountFollows,
                arguments: FollowsPageArguments(
                  username: username,
                  initialIndex: 0,
                ),
              );
            },
            child: Column(
              children: [
                Text(
                  _formattedSocialValue(followersCount),
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
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
              Navigator.of(context).pushNamed(
                RouteNames.accountFollows,
                arguments: FollowsPageArguments(
                  username: username,
                  initialIndex: 1,
                ),
              );
            },
            child: Column(
              children: [
                Text(
                  _formattedSocialValue(followingCount),
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
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
