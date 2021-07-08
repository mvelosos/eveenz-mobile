import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/events_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/event_model.dart';

class EventPageArguments {
  final String uuid;

  EventPageArguments({required this.uuid});
}

class EventPage extends StatefulWidget {
  final EventPageArguments args;

  EventPage({required this.args});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  EventsController _eventsController = locator<EventsController>();
  EventModel _event = EventModel();

  @override
  void initState() {
    super.initState();
    _getEvent();
  }

  void _getEvent() async {
    var result = await _eventsController.getEvent(widget.args.uuid);
    if (result.isRight()) {
      _event = result.getOrElse(() => {} as EventModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.args.uuid),
      ),
    );
  }
}
