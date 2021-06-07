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
import 'package:party_mobile/app/pages/new_event/new_event_page.dart';
import 'package:party_mobile/app/pages/notifications/notifications_page.dart';
import 'package:party_mobile/app/pages/profile/profile_page.dart';
import 'package:party_mobile/app/pages/root/root_page.dart';
import 'package:party_mobile/app/pages/search/search_page.dart';
import 'package:party_mobile/app/pages/settings/profile_settings/profile_settings_page.dart';
import 'package:party_mobile/app/pages/settings/profile_settings/update_bio_page/update_bio_page.dart';
import 'package:party_mobile/app/pages/settings/profile_settings/update_name_page/update_name_page.dart';
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
        final args = route.arguments as ForgotPasswordPage2Arguments;
        return MaterialPageRoute(
          builder: (_) => ForgotPassword2Page(args: args),
        );

      case RouteNames.forgotPassword3:
        final args = route.arguments as ForgotPasswordPage3Arguments;
        return MaterialPageRoute(
          builder: (_) => ForgotPassword3Page(args: args),
        );

      case RouteNames.forgotPassword4:
        return MaterialPageRoute(builder: (_) => ForgotPassword4Page());

      case RouteNames.showAccount:
        final args = route.arguments as AccountPageArguments;
        return MaterialPageRoute(
          builder: (_) => AccountPage(args: args),
        );

      case RouteNames.accountFollows:
        final args = route.arguments as FollowsPageArguments;
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

      // Settings
      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) => SettingsPage());

      case RouteNames.profileSettings:
        return MaterialPageRoute(builder: (_) => ProfileSettingsPage());

      case RouteNames.updateNameSettings:
        return MaterialPageRoute(builder: (_) => UpdateNamePage());

      case RouteNames.updateBioSettings:
        return MaterialPageRoute(builder: (_) => UpdateBioPage());

      // Events
      case RouteNames.newEvent:
        return MaterialPageRoute(builder: (_) => NewEventPage());

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
