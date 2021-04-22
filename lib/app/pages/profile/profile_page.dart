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

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
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
                                image: NetworkImage(_meStore.avatarUrl.value),
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
                  )
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
        ),
      );
    });
  }
}
