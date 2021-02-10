import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:device_preview/device_preview.dart';

import 'app/app.dart';

void main() {
  setupLocator();
  runApp(
    DevicePreview(
      enabled: false, // Always set false when app will be deployed
      builder: (context) => App(),
    ),
  );
}
