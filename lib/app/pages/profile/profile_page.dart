import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/widgets/profile_popularity_badge.dart';
import 'package:party_mobile/app/shared/widgets/profile_bio.dart';
import 'package:party_mobile/app/pages/profile/widgets/profile_tab_view.dart';
import 'package:party_mobile/app/shared/widgets/profile_social_row.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/widgets/profile_avatar.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController = locator<ProfileController>();
  final ProfileStore _profileStore = locator<ProfileStore>();

  Widget _appBarUsernameTitle() {
    if (_profileStore.accountSetting['private'] != null &&
        _profileStore.accountSetting['private']) {
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            _profileStore.username.value + ' ',
            style: GoogleFonts.poppins(
              color: AppColors.darkPurple,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            Icons.lock,
            color: Colors.black,
            size: 17,
          )
        ],
      );
    }

    return Text(
      _profileStore.username.value,
      style: GoogleFonts.poppins(
        color: AppColors.darkPurple,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Obx(() => _appBarUsernameTitle()),
              centerTitle: true,
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              brightness: Brightness.light,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.cog,
                    size: 20,
                  ),
                  color: Colors.grey,
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                    Get.toNamed('/settings');
                  },
                ),
              ],
            ),
            body: RefreshIndicator(
              color: AppColors.orange,
              displacement: 0,
              onRefresh: () async {
                await _profileController.getProfile();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Container(
                  color: Colors.white,
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: _size.width * .06,
                          right: _size.width * .06,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: _size.height * .015),
                            Obx(
                              () => ProfileAvatar(
                                _profileStore.avatarUrl.value,
                              ),
                            ),
                            SizedBox(height: _size.height * .03),
                            Obx(
                              () => AutoSizeText(
                                _profileStore.name.value,
                                minFontSize: 17,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            SizedBox(height: _size.height * .02),
                            Obx(
                              () => ProfilePopularityBadge(
                                _profileStore.popularity.value,
                              ),
                            ),
                            SizedBox(height: _size.height * .02),
                            Obx(
                              () => ProfileBio(_profileStore.bio.value),
                            ),
                            Obx(
                              () => ProfileSocialRow(
                                context: context,
                                username: _profileStore.username.value,
                                eventsCount: _profileStore.events.value,
                                followersCount: _profileStore.followers.value,
                                followingCount: _profileStore.following.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _size.height * .03),
                      ProfileTabView()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
