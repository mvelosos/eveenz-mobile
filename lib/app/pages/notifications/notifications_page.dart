import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notificações',
          style: GoogleFonts.inter(
            fontSize: size.height * .025,
            color: AppColors.darkPurple,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarOpacity: 1,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        shape: Border(
          bottom: BorderSide(color: AppColors.grayLight, width: 1),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: size.width * .08,
          right: size.width * .08,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
