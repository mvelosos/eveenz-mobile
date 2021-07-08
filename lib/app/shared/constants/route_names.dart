// This file contains all the routing constants used within the app
class RouteNames {
  // Root
  static const String root = '/';
  static const String appContainer = '/app_container';
  static const String login = '/login';
  static const String signUp1 = '/signup/1';
  static const String signUp2 = '/signup/2';

  static const String forgotPassword1 = '/forgot_password/1';
  static const String forgotPassword2 = '/forgot_password/2';
  static const String forgotPassword3 = '/forgot_password/3';
  static const String forgotPassword4 = '/forgot_password/4';

  static const String showAccount = '/accounts/:username';
  static const String accountFollows = '/accounts/follows';

  static const String showEvent = '/events/:uuid';

  // Home
  static const String home = '/home';

  // Search
  static const String search = '/search';

  // Map
  static const String map = '/map';

  // Notifications
  static const String notifications = '/notifications';

  // Profile
  static const String profile = '/profile';

  // Settings
  static const String settings = '/settings';
  static const String profileSettings = '/settings/profile';
  static const String updateNameSettings = '/settings/profile/update_name';
  static const String updateUsernameSettings =
      '/settings/profile/update_username';
  static const String updateBioSettings = '/settings/profile/update_bio';
  static const String privacySettings = '/settings/privacy';

  // Events
  static const String newEvent = '/events/new';
}
