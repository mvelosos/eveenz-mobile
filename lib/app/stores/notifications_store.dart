import 'package:get/get.dart';

class NotificationsStore {
  RxBool showNotificationBadge = false.obs;

  void setShowNotificationBadge(bool value) {
    showNotificationBadge.value = value;
  }
}
