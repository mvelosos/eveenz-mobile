import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class ForgotPassword4Page extends StatefulWidget {
  @override
  _ForgotPassword4PageState createState() => _ForgotPassword4PageState();
}

class _ForgotPassword4PageState extends State<ForgotPassword4Page> {
  NavigationService _navigationService;

  // Widgets

  Widget _submitButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _navigationService.pushReplacementNamedNoAnimation(RouteNames.login);
      },
      child: Container(
        width: _size.width,
        margin: EdgeInsets.symmetric(vertical: _size.height * .007),
        padding: EdgeInsets.symmetric(vertical: _size.height * .024),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: AppColors.orange,
        ),
        child: Text(
          'ENTRAR',
          style: GoogleFonts.roboto(
              fontSize: _size.height * .015,
              color: Colors.white,
              letterSpacing: 4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _navigationService = NavigationService.currentNavigator(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SafeArea(
                child: Container(
              height: constraints.maxHeight,
              padding: EdgeInsets.only(
                left: size.width * .08,
                right: size.width * .08,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * .1),
                  Text(
                    'Senha alterada!',
                    style: GoogleFonts.inter(
                      fontSize: size.height * .035,
                      color: AppColors.darkPurple,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: size.height * .005),
                  Text(
                    'Sua nova senha foi alterada com sucesso! Clique em entrar para fazer seu login',
                    style: GoogleFonts.poppins(
                      fontSize: size.height * .016,
                      color: AppColors.darkPurple,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: size.height * .07),
                  Center(
                    child: Image(
                      image: AssetImage(
                        'assets/images/password_recover_success.png',
                      ),
                      height: constraints.maxHeight * .35,
                    ),
                  ),
                  SizedBox(height: size.height * .09),
                  _submitButton(context)
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
