import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/stores/notifications_store.dart';
import 'package:party_mobile/app/websocket.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationsStore _notificationsStore = locator<NotificationsStore>();

  @override
  void initState() {
    super.initState();
    Websocket.initConnection();
  }

  _subscribeChannel() {
    var cable = Websocket.instance;

    cable.subscribe(
      "Notification", // either "Chat" and "ChatChannel" is fine
      channelParams: {'room': 'private'},
      onSubscribed: () {
        print('deu bom');
      }, // `confirm_subscription` received
      onDisconnected: () {
        print('disconected');
      }, // `disconnect` received
      onMessage: (Map message) {
        print(message);
        _notificationsStore.setShowNotificationBadge(true);
      }, // any other message received
    );
  }

  _unsubscribeChannel() {
    // var cable = Websocket.instance;
    // cable.unsubscribe(
    //   "Notification", // either "Chat" and "ChatChannel" is fine
    //   channelParams: {"room": "private"},
    // );
    _notificationsStore.setShowNotificationBadge(false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notificações',
          style: GoogleFonts.inter(
            fontSize: size.height * .025,
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
      body: Container(
        padding: EdgeInsets.only(
          left: size.width * .08,
          right: size.width * .08,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: _subscribeChannel,
              child: Text('Conectar Channel'),
            ),
            TextButton(
              onPressed: _unsubscribeChannel,
              child: Text('Desconectar Channel'),
            )
          ],
        ),
      ),
    );
  }
}
