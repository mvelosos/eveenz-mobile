import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:party_mobile/app/shared/constants/api_keys.dart';

void setupOneSignal() async {
  OneSignal.shared.setAppId(ApiKeys.kOneSignalKey);

  // OneSignal.shared.setAppId("YOUR_ONESIGNAL_APP_ID");

  // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //   print("Accepted permission: $accepted");
  // });
  // OneSignal Initialization
// var settings = {
//   OSiOSSettings.autoPrompt: false,
//   OSiOSSettings.promptBeforeOpeningPushUrl: true
// };
// OneSignal.shared
//         .init(ApiKeys.kOneSignalKey, iOSSettings: settings);
}
