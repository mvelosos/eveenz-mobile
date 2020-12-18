class Urls {
  static const String protocol = 'http';
  static const String apiVersion = 'v1';
  // static const String baseUrl = '10.0.2.2:3000'; //Use this when running on Android Emulator
  static const String baseUrl = '127.0.0.1:3000';

  String get apiUrl {
    return '$protocol://$baseUrl/api/$apiVersion';
  }
}
