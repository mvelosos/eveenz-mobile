import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NavigationService _navigationService;

  @override
  Widget build(BuildContext context) {
    _navigationService = NavigationService.currentNavigator(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/home_logo.png',
            fit: BoxFit.cover,
            height: 27,
          ),
          titleSpacing: 25,
          centerTitle: false,
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
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
                  Container(
                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      minWidth: 0,
                      onPressed: () {
                        _navigationService.pushNamed(RouteNames.newEvent);
                      },
                      child: Icon(
                        Icons.add_circle,
                        size: 35,
                        color: AppColors.purple,
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
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
