import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/me_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/profile/widgets/popularity_badge.dart';
import 'package:party_mobile/app/pages/profile/widgets/profile_bio.dart';
import 'package:party_mobile/app/pages/profile/widgets/social_row.dart';
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
              backgroundColor: Colors.transparent,
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
              color: Colors.blue,
              displacement: 0,
              onRefresh: () async {
                await _meController.getMe();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Container(
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
                            Obx(
                              () => _meStore.avatarUrl.value != ''
                                  ? Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              _meStore.avatarUrl.value),
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Color(0xffd3d5db),
                                    ),
                            ),
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
                            PopularityBadge(),
                            SizedBox(height: _size.height * .02),
                            ProfileBio(),
                            SocialRow()
                          ],
                        ),
                      ),
                      SizedBox(height: _size.height * .03),
                      SizedBox(
                        height: 50,
                        child: AppBar(
                          backgroundColor: AppColors.grayLight2,
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
                          elevation: 0,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Container(
                              color: AppColors.grayLight2,
                              child: Text('oi'),
                            ),
                            Container(
                              color: AppColors.grayLight2,
                              child: Text('fon'),
                            )
                          ],
                        ),
                      )
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
