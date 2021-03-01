import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:party_mobile/app/shared/constants/api_keys.dart';

void setupOneSignal() async {
  OneSignal.shared.init(ApiKeys.kOneSignalKey, iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });

  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
}
