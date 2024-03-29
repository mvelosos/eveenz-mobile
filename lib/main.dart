import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:device_preview/device_preview.dart';
import 'package:party_mobile/app/one_signal.dart';
import 'package:party_mobile/app/shared/constants/api_keys.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/foundation.dart';

import 'app/app.dart' as myApp;

void main() async {
  if (kReleaseMode) {
    await runRelease();
  } else {
    await runDebug();
  }

  setupLocator();
  setupOneSignal();
}

Future<void> runRelease() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = ApiKeys.kSentryDns;
    },
    appRunner: () => runApp(myApp.App()),
  );
}

Future<void> runDebug() async {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => myApp.App(),
    ),
  );
}
