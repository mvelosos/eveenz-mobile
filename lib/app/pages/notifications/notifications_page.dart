import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/notifications_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/notification_model.dart';
import 'package:party_mobile/app/pages/notifications/widgets/account_follow_list_tile.dart';
import 'package:party_mobile/app/pages/notifications/widgets/account_request_follow_list_tile.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/stores/notifications_store.dart';
import 'package:party_mobile/app/websocket.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationsController _notificationsController =
      locator<NotificationsController>();
  final NotificationsStore _notificationsStore = locator<NotificationsStore>();
  List<NotificationModel>? _notificationsList;

  @override
  void initState() {
    super.initState();
    // Websocket.initConnection();
    // _subscribeChannel();
    _getNotifications();
  }

  Future<void> _getNotifications() async {
    var result = await _notificationsController.getNotifications();
    if (result.isRight()) {
      setState(() {
        _notificationsList =
            result.getOrElse(() => {} as List<NotificationModel>);
      });
    }
  }

  _subscribeChannel() {
    var cable = Websocket.instance;

    cable.subscribe(
      "Notification",
      channelParams: {'room': 'private'},
      onSubscribed: () {
        print('deu bom');
      },
      onDisconnected: () {
        print('disconected');
      },
      onMessage: (Map message) {
        print(message);
        _notificationsStore.setShowNotificationBadge(true);
      },
    );
  }

  _unsubscribeChannel() {
    var cable = Websocket.instance;
    cable.unsubscribe(
      "Notification",
      channelParams: {"room": "private"},
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notificações',
            style: GoogleFonts.inter(
              fontSize: size.height * .026,
              color: AppColors.darkPurple,
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          toolbarOpacity: 1,
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
          shape: Border(
            bottom: BorderSide(color: AppColors.grayLight, width: 1),
          ),
        ),
        body: RefreshIndicator(
          color: AppColors.orange,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          displacement: 15,
          onRefresh: () async {
            await _getNotifications();
          },
          child: Scrollbar(
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _notificationsList != null &&
                            _notificationsList!.length > 0
                        ? ListView.builder(
                            itemCount: _notificationsList?.length,
                            itemBuilder: (_, index) {
                              if (_notificationsList?[index].notificationType ==
                                  'follow') {
                                return AccountFollowListTile(
                                  _notificationsList![index],
                                  _getNotifications,
                                );
                              }
                              if (_notificationsList?[index].notificationType ==
                                  'request_follow') {
                                return AccountRequestFollowListTile(
                                  _notificationsList![index],
                                  _getNotifications,
                                );
                              }
                              return SizedBox.shrink();
                            },
                          )
                        : SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: size.width / 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                    'assets/images/no_notifications.png',
                                  ),
                                  height: constraints.maxHeight * .2,
                                ),
                                SizedBox(height: 25),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Opa, parece que você não tem nenhuma notificação',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  // TextButton(
                  //   onPressed: _unsubscribeChannel,
                  //   child: Text('Desconectar Channel'),
                  // )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
