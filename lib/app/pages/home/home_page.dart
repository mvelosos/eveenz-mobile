import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/pages/home/widgets/events_tab_view.dart';
import 'package:party_mobile/app/pages/new_event/new_event_page.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/home_logo.png',
            fit: BoxFit.cover,
            height: 27,
          ),
          titleSpacing: 15,
          centerTitle: false,
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              // margin: EdgeInsets.only(left: 10, right: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: TabBar(
                      indicatorColor: AppColors.purple,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 3,
                      unselectedLabelColor: Colors.grey[400],
                      labelColor: AppColors.darkPurple,
                      isScrollable: true,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                      tabs: [
                        Tab(
                          icon: Text('Eventos'),
                        ),
                        Tab(
                          icon: Text('Social'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      child: MaterialButton(
                        minWidth: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.purple,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          Get.to(() => NewEventPage());
                        },
                        child: Row(
                          children: [
                            Text(
                              'Criar evento',
                              style: GoogleFonts.inter(
                                color: AppColors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              size: 23,
                              color: AppColors.purple,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            EventsTabView(),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
