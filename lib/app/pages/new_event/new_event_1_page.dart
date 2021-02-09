import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class NewEvent1Page extends StatefulWidget {
  @override
  _NewEvent1PageState createState() => _NewEvent1PageState();
}

class _NewEvent1PageState extends State<NewEvent1Page> {
  NavigationService _navigationService;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _navigationService = NavigationService.currentNavigator(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.orange),
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              width: size.width,
              height: size.height,
              padding: EdgeInsets.only(
                left: size.width * .08,
                right: size.width * .08,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * .02),
                    Text(
                      'Criar evento',
                      style: GoogleFonts.inter(
                        fontSize: size.height * .04,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkPurple,
                      ),
                    ),
                    SizedBox(height: size.height * .005),
                    Text(
                      'Vamos precisar de algumas informações sobre seu evento',
                      style: GoogleFonts.poppins(
                        fontSize: size.height * .016,
                        color: AppColors.darkPurple,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
