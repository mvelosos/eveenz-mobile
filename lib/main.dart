import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:device_preview/device_preview.dart';

import 'app/app.dart';

void main() async {
  setupLocator();
  runApp(
    DevicePreview(
      enabled: false, // Always set false when app will be deployed
      builder: (context) => App(),
    ),
  );

  //Remove this method to stop OneSignal Debugging

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init("b7cce030-0265-4920-8e30-102a7125a584", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
}
