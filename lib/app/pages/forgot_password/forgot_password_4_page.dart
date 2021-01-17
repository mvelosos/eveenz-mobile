import 'package:flutter/material.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class ForgotPassword4Page extends StatefulWidget {
  @override
  _ForgotPassword4PageState createState() => _ForgotPassword4PageState();
}

class _ForgotPassword4PageState extends State<ForgotPassword4Page> {
  NavigationService _navigationService;

  @override
  Widget build(BuildContext context) {
    _navigationService = NavigationService.currentNavigator(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sua senha foi alterada com sucesso!'),
                  Text('Faça seu login novamente'),
                  SizedBox(height: size.height * .03),
                  RaisedButton(
                    onPressed: () {
                      _navigationService
                          .pushReplacementNamedNoAnimation(RouteNames.login);
                    },
                    child: Text('Voltar a tela de login'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
