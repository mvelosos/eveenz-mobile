class Endpoints {
  // Auth Endpoints
  static const String authLogin = '/auth/login';
  static const String authFacebook = '/auth/facebook';

  // Search Endpoints
  static const String search = '/search';

  // Profile Endpoints
  static const String me = '/me';

  // Accounts Endpoints
  static const String accountShow = '/accounts/:username';
  static const String accountFollowers = '/accounts/:username/followers';
  static const String accountFollowing = '/accounts/:username/following';
  static const String accountFollow = '/me/follows/accounts';

  // Users Endpoints
  static const String users = '/users';
}
