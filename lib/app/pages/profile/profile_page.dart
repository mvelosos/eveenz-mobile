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

    return Scaffold(
      appBar: AppBar(
        // title: Obx(
        //   () => Text(
        //     _meStore.username.value,
        //     style: TextStyle(color: Colors.blue),
        //   ),
        // ),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return RefreshIndicator(
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
                padding: EdgeInsets.only(
                  left: _size.width * .06,
                  right: _size.width * .06,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Obx(
                            () {
                              return _meStore.avatarUrl.value != ''
                                  ? Image.network(
                                      _meStore.avatarUrl.value,
                                      height: 95,
                                      width: 95,
                                    )
                                  : CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Color(0xffd3d5db),
                                    );
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => AutoSizeText(_meStore.name.toString(),
                                      minFontSize: 16,
                                      // maxFontSize: 22,
                                      // overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.darkPurple,
                                        fontSize: 22,
                                      )),
                                ),
                                Obx(
                                  () => AutoSizeText(
                                      '@${_meStore.username.toString()}',
                                      minFontSize: 15,
                                      style: GoogleFonts.inter(
                                        color: AppColors.gray1,
                                        fontSize: 5,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                // child: Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Column(
                //           children: [
                //             Obx(
                //               () => Text(
                //                 _meStore.events.value.toString(),
                //                 style: TextStyle(fontSize: 19),
                //               ),
                //             ),
                //             Text('Festas'),
                //           ],
                //         ),
                //         GestureDetector(
                //           onTap: () {
                //             _navigationService.pushNamed(
                //               RouteNames.accountFollows,
                //               arguments: FollowsPageArguments(
                //                 username: _meStore.username.value,
                //                 initialIndex: 0,
                //               ),
                //             );
                //           },
                //           child: Column(
                //             children: [
                //               Obx(
                //                 () => Text(
                //                   _meStore.followers.value.toString(),
                //                   style: TextStyle(fontSize: 19),
                //                 ),
                //               ),
                //               Text('Seguidores'),
                //             ],
                //           ),
                //         ),
                //         GestureDetector(
                //           onTap: () {
                //             _navigationService.pushNamed(
                //               RouteNames.accountFollows,
                //               arguments: FollowsPageArguments(
                //                 username: _meStore.username.value,
                //                 initialIndex: 1,
                //               ),
                //             );
                //           },
                //           child: Column(
                //             children: [
                //               Obx(
                //                 () => Text(
                //                   _meStore.following.value.toString(),
                //                   style: TextStyle(fontSize: 19),
                //                 ),
                //               ),
                //               Text('Seguindo'),
                //             ],
                //           ),
                //         ),
                //         ClipRRect(
                //           borderRadius: BorderRadius.circular(50),
                //           child: Obx(
                //             () {
                //               return _meStore.avatarUrl.value != ''
                //                   ? Image.network(
                //                       _meStore.avatarUrl.value,
                //                       height: 85,
                //                       width: 85,
                //                     )
                //                   : CircleAvatar(
                //                       radius: 45,
                //                       backgroundColor: Color(0xffd3d5db),
                //                     );
                //             },
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
