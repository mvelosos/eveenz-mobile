import 'package:flutter/material.dart';
import 'package:party_mobile/app/pages/account/account_page.dart';
import 'package:party_mobile/app/pages/app_container/app_container.dart';
import 'package:party_mobile/app/pages/follows/follows_page.dart';
import 'package:party_mobile/app/pages/forgot_password/forgot_password_1_page.dart';
import 'package:party_mobile/app/pages/forgot_password/forgot_password_2_page.dart';
import 'package:party_mobile/app/pages/forgot_password/forgot_password_3_page.dart';
import 'package:party_mobile/app/pages/forgot_password/forgot_password_4_page.dart';
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

      // Forgot Password
      case RouteNames.forgotPassword1:
        return MaterialPageRoute(builder: (_) => ForgotPassword1Page());

      case RouteNames.forgotPassword2:
        ForgotPasswordPage2Arguments args = route.arguments;
        return MaterialPageRoute(
          builder: (_) => ForgotPassword2Page(args: args),
        );

      case RouteNames.forgotPassword3:
        return MaterialPageRoute(builder: (_) => ForgotPassword3Page());

      case RouteNames.forgotPassword4:
        return MaterialPageRoute(builder: (_) => ForgotPassword4Page());

      case RouteNames.showAccount:
        AccountPageArguments args = route.arguments;
        return MaterialPageRoute(
          builder: (_) => AccountPage(args: args),
        );

      case RouteNames.accountFollows:
        FollowsPageArguments args = route.arguments;
        return MaterialPageRoute(
          builder: (_) => FollowsPage(args: args),
        );

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
