class Endpoints {
  // Accounts Endpoints
  static const String accountShow = '/accounts/:username';
  static const String accountFollowers = '/accounts/:username/followers';
  static const String accountFollowing = '/accounts/:username/following';
  static const String accountFollow = '/me/follows/accounts';

  // Auth Endpoints
  static const String authLogin = '/auth/login';
  static const String authFacebook = '/auth/facebook';
  static const String authGoogle = '/auth/google';
  static const String authApple = '/auth/apple';

  // Passwords Endpoints
  static const String passwordsForgot = '/passwords/forgot';
  static const String passwordsVerifyCode = '/passwords/verify_code';
  static const String passwordsRecover = '/passwords/recover_password';

  // Profile Endpoints
  static const String me = '/me';

  // Search Endpoints
  static const String search = '/search';

  // Users Endpoints
  static const String users = '/users';
  static const String usernameAvailable = '/users/username_available';

  // Categories Endpoints
  static const String categories = '/categories';
}
