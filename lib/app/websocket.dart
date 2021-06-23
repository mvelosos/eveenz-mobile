import 'package:action_cable/action_cable.dart';
import 'package:party_mobile/app/shared/constants/urls.dart';

class Websocket {
  static ActionCable? cable;

  static initConnection() {
    cable = ActionCable.Connect(Urls.wsUrl, headers: {
      "Authorization": "Some Token",
    }, onConnected: () {
      print("connected");
    }, onConnectionLost: () {
      print("connection lost");
    }, onCannotConnect: () {
      print("cannot connect");
    });
  }

  static finishConection() {
    cable?.disconnect();
  }

  static ActionCable get instance => cable!;

  static tryReconect() {
    // const conectTimer = Duration(seconds: 5);
    // var timer = Timer.periodic(
    //   conectTimer,
    //   (Timer t) => {
    //     print('Trying to reconect to WS server...'),
    //     initConnection(),
    //   },
    // );
  }
}
