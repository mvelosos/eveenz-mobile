import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/pages/signup/widgets/signup_bezier_container.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class SignUpPage2 extends StatefulWidget {
  @override
  _SignUpPage2State createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  NavigationService _navigationService;

  // Widgets

  Widget _goToAppButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _navigationService.pushReplacementNamedNoAnimation(RouteNames.root);
      },
      child: Container(
        width: _size.width,
        margin: EdgeInsets.symmetric(vertical: _size.height * .007),
        padding: EdgeInsets.symmetric(vertical: _size.height * .024),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
          color: AppColors.orange,
        ),
        child: Text(
          'IR PARA O APP',
          style: GoogleFonts.roboto(
            fontSize: _size.height * .017,
            color: Colors.white,
            letterSpacing: 4.2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _navigationService = NavigationService.currentNavigator(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC4C4C4).withOpacity(.15),
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.orange),
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  height: constraints.maxHeight,
                  child: Stack(
                    children: [
                      SignUpBezierContainer(),
                      Container(
                        padding: EdgeInsets.only(
                          left: size.width * .08,
                          right: size.width * .08,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height * .01),
                              Text(
                                'Aêeeee!',
                                style: GoogleFonts.inter(
                                  fontSize: 31,
                                  color: AppColors.darkPurple,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: size.height * .005),
                              Text(
                                'Cadastro concluído com succeso. Você já está pronto para viver bons momentos com o Eveenz!',
                                style: GoogleFonts.poppins(
                                  fontSize: size.height * 0.016,
                                  color: AppColors.darkPurple,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: size.height * .04),
                              Image(
                                image: AssetImage(
                                  'assets/images/signup_complete.png',
                                ),
                                height: constraints.maxHeight * 0.5,
                              ),
                              SizedBox(height: size.height * .05),
                              _goToAppButton(context)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
