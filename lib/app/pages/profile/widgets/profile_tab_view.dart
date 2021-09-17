import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_mobile/app/pages/profile/widgets/profile_events_tab.dart';
import 'package:party_mobile/app/pages/profile/widgets/profile_social_tab.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class ProfileTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.profileTabViewContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: AppBar(
              backgroundColor: AppColors.profileTabViewContainer,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              bottom: TabBar(
                indicatorWeight: 4,
                indicatorColor: AppColors.purple,
                tabs: [
                  Tab(
                    icon: FaIcon(
                      FontAwesomeIcons.calendarAlt,
                      size: 20,
                      color: AppColors.purple,
                    ),
                  ),
                  Tab(
                    icon: FaIcon(
                      FontAwesomeIcons.commentAlt,
                      size: 20,
                      color: AppColors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 310,
            child: TabBarView(
              children: [
                ProfileEventsTab(),
                ProfileSocialTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
