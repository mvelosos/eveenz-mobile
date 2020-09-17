class Urls {
  static const String protocol = 'http';
  static const String apiVersion = 'v1';
  static const String baseUrl = 'localhost:3000';

  String get apiUrl {
    return '$protocol://$baseUrl/api/$apiVersion';
  }
}
