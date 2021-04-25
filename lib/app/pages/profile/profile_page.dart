import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/me_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/follows/follows_page.dart';
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
                  '@${_meStore.username.value}',
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
                            Container(
                              width: 110,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.3),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.trophy,
                                    size: 15,
                                    color: AppColors.yellowGold,
                                  ),
                                  SizedBox(width: 7),
                                  Obx(
                                    () => Text(
                                      _meStore.popularity.value.toString(),
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: _size.height * .02),
                            Obx(
                              () => AutoSizeText(
                                _meStore.bio.value,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            SizedBox(height: _size.height * .02),
                            IntrinsicHeight(
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _size.height * .05),
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
