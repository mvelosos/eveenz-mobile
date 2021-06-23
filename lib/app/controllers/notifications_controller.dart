import 'package:dartz/dartz.dart';
import 'package:party_mobile/app/models/notification_model.dart';
import 'package:party_mobile/app/repositories/notifications_repository.dart';
import 'package:party_mobile/app/shared/errors/errors.dart';

class NotificationsController {
  NotificationsRepository _notificationsRepository = NotificationsRepository();

  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    List<NotificationModel> notificationsList = [];
    var result = await _notificationsRepository.getNotifications();
    if (result.isRight()) {
      dynamic resultList = result.getOrElse(() => {});
      if (resultList['notifications'] != null ||
          resultList['notifications'] != []) {
        resultList['notifications'].forEach(
          (notification) => notificationsList.add(
            NotificationModel.fromJson(notification),
          ),
        );
      }
    }
    return Right(notificationsList);
  }
}
