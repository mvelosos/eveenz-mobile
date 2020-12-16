import 'package:flutter/material.dart';
import 'package:party_mobile/app/pages/app_container/app_container.dart';
import 'package:party_mobile/app/pages/forgot_password/forgot_password_page.dart';
import 'package:party_mobile/app/pages/home/home_page.dart';
import 'package:party_mobile/app/pages/login/login_page.dart';
import 'package:party_mobile/app/pages/root/root_page.dart';
import 'package:party_mobile/app/pages/settings/settings_page.dart';
import 'package:party_mobile/app/pages/signup/signup_page.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings route) {
    switch (route.name) {
      case RouteNames.root:
        return MaterialPageRoute(builder: (_) => RootPage());

      case RouteNames.appContainer:
        return MaterialPageRoute(builder: (_) => AppContainer());

      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case RouteNames.signUp:
        return MaterialPageRoute(builder: (_) => SignUpPage());

      case RouteNames.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());

      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomePage());

      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) => SettingsPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${route.name}'),
            ),
          ),
        );
    }
  }
}
