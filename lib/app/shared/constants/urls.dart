class Urls {
  // Use http for development and https for deploys
  static const String protocol = 'https';

  // Always v1
  static const String apiVersion = 'v1';

  //Use Android Emulator ip when running on Android Emulators
  // static const String baseUrl = '10.0.2.2:3000';

  // Use when running on real device
  // static const String baseUrl = '192.168.0.12:3000';

  // Use when running on iPhone Simulator
  // static const String baseUrl = '127.0.0.1:3000';

  // Production URL
  static const String baseUrl = 'eveenz-production.herokuapp.com';

  String get apiUrl {
    return '$protocol://$baseUrl/api/$apiVersion';
  }
}
