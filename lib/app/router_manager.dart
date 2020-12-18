import 'package:flutter/material.dart';
import 'package:party_mobile/app/pages/app_container/app_container.dart';
import 'package:party_mobile/app/pages/forgot_password/forgot_password_page.dart';
import 'package:party_mobile/app/pages/home/home_page.dart';
import 'package:party_mobile/app/pages/login/login_page.dart';
import 'package:party_mobile/app/pages/map/map_page.dart';
import 'package:party_mobile/app/pages/notifications/notifications_page.dart';
import 'package:party_mobile/app/pages/profile/profile_page.dart';
import 'package:party_mobile/app/pages/root/root_page.dart';
import 'package:party_mobile/app/pages/search/search_page.dart';
import 'package:party_mobile/app/pages/settings/settings_page.dart';
import 'package:party_mobile/app/pages/signup/signup_page.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings route) {
    switch (route.name) {
      // Root
      case RouteNames.root:
        return MaterialPageRoute(
            builder: (_) => RootPage(),
            settings: RouteSettings(name: RouteNames.root));

      case RouteNames.appContainer:
        return MaterialPageRoute(builder: (_) => AppContainer());

      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case RouteNames.signUp:
        return MaterialPageRoute(builder: (_) => SignUpPage());

      case RouteNames.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());

      // Home
      case RouteNames.home:
        return MaterialPageRoute(
            builder: (_) => HomePage(),
            settings: RouteSettings(name: RouteNames.home),
            fullscreenDialog: true);

      // Search
      case RouteNames.search:
        return MaterialPageRoute(
            builder: (_) => SearchPage(),
            settings: RouteSettings(name: RouteNames.search),
            fullscreenDialog: true);

      // Map
      case RouteNames.map:
        return MaterialPageRoute(
            builder: (_) => MapPage(),
            settings: RouteSettings(name: RouteNames.map),
            fullscreenDialog: true);

      // Notifications
      case RouteNames.notifications:
        return MaterialPageRoute(
            builder: (_) => NotificationsPage(),
            settings: RouteSettings(name: RouteNames.notifications),
            fullscreenDialog: true);

      // Profile
      case RouteNames.profile:
        return MaterialPageRoute(
            builder: (_) => ProfilePage(),
            settings: RouteSettings(name: RouteNames.profile),
            fullscreenDialog: true);

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
