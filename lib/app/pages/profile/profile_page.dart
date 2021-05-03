import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/me_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/profile/widgets/profile_popularity_badge.dart';
import 'package:party_mobile/app/pages/profile/widgets/profile_avatar.dart';
import 'package:party_mobile/app/pages/profile/widgets/profile_bio.dart';
import 'package:party_mobile/app/pages/profile/widgets/profile_tab_view.dart';
import 'package:party_mobile/app/pages/profile/widgets/profile_social_row.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/stores/me_store.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  NavigationService _navigationService;
  var _meController = locator<MeController>();
  var _meStore = locator<MeStore>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _navigationService = NavigationService.currentNavigator(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Obx(
                () => Text(
                  _meStore.atUsername,
                  style: GoogleFonts.poppins(
                    color: AppColors.darkPurple,
                    fontSize: 16,
                  ),
                ),
              ),
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
                    _navigationService.pushNamed(RouteNames.settings);
                  },
                ),
              ],
            ),
            body: RefreshIndicator(
              color: AppColors.purple,
              displacement: 0,
              onRefresh: () async {
                await _meController.getMe();
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
                            SizedBox(height: _size.height * .03),
                            ProfileAvatar(),
                            SizedBox(height: _size.height * .03),
                            Obx(
                              () => AutoSizeText(
                                _meStore.name.value,
                                minFontSize: 17,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            SizedBox(height: _size.height * .02),
                            ProfilePopularityBadge(),
                            SizedBox(height: _size.height * .02),
                            ProfileBio(),
                            ProfileSocialRow(_navigationService)
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
