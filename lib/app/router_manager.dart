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
import 'package:party_mobile/app/pages/new_event/new_event_1_page.dart';
import 'package:party_mobile/app/pages/new_event/new_event_2_page.dart';
import 'package:party_mobile/app/pages/new_event/new_event_3_page.dart';
import 'package:party_mobile/app/pages/new_event/new_event_4_page.dart';
import 'package:party_mobile/app/pages/notifications/notifications_page.dart';
import 'package:party_mobile/app/pages/profile/profile_page.dart';
import 'package:party_mobile/app/pages/root/root_page.dart';
import 'package:party_mobile/app/pages/search/search_page.dart';
import 'package:party_mobile/app/pages/settings/settings_page.dart';
import 'package:party_mobile/app/pages/signup/signup_page_1.dart';
import 'package:party_mobile/app/pages/signup/signup_page_2.dart';
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

      case RouteNames.signUp1:
        return MaterialPageRoute(builder: (_) => SignUpPage1());

      case RouteNames.signUp2:
        return MaterialPageRoute(builder: (_) => SignUpPage2());

      // Forgot Password
      case RouteNames.forgotPassword1:
        return MaterialPageRoute(builder: (_) => ForgotPassword1Page());

      case RouteNames.forgotPassword2:
        ForgotPasswordPage2Arguments args = route.arguments;
        return MaterialPageRoute(
          builder: (_) => ForgotPassword2Page(args: args),
        );

      case RouteNames.forgotPassword3:
        ForgotPasswordPage3Arguments args = route.arguments;
        return MaterialPageRoute(
          builder: (_) => ForgotPassword3Page(args: args),
        );

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

      // Events
      case RouteNames.newEvent1:
        return MaterialPageRoute(builder: (_) => NewEvent1Page());

      case RouteNames.newEvent2:
        NewEvent2PageArguments args = route.arguments;
        return MaterialPageRoute(builder: (_) => NewEvent2Page(args: args));

      case RouteNames.newEvent3:
        NewEvent3PageArguments args = route.arguments;
        return MaterialPageRoute(builder: (_) => NewEvent3Page(args: args));

      case RouteNames.newEvent4:
        NewEvent4PageArguments args = route.arguments;
        return MaterialPageRoute(builder: (_) => NewEvent4Page(args: args));

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
