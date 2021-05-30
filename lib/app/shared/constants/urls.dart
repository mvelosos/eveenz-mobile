import 'package:flutter/foundation.dart';

class Urls {
  static String prodProtocol = 'https';
  static String prodBaseUrl = 'eveenz-production.herokuapp.com';
  static String prodApiVersion = 'v1';

  static String protocol = 'http';
  static String apiVersion = 'v1';
  // static String baseUrl = 'localhost:3000';

  //Use Android Emulator ip when running on Android Emulators
  // static String baseUrl = '10.0.2.2:3000';

  // Use when running on iPhone Simulator
  static String baseUrl = '192.168.0.12:3000';

  String get apiUrl {
    if (kReleaseMode) {
      return '$prodProtocol://$prodBaseUrl/api/$prodApiVersion';
    }

    return '$protocol://$baseUrl/api/$apiVersion';
  }
}
