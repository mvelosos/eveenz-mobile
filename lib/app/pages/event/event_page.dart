import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.args.uuid),
      ),
    );
  }
}
