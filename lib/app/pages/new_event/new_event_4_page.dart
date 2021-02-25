import 'package:flutter/material.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

// Page Arguments
class NewEvent4PageArguments {
  final NewEventVM newEvent;

  NewEvent4PageArguments({@required this.newEvent});
}

// Page
class NewEvent4Page extends StatefulWidget {
  final NewEvent4PageArguments args;

  NewEvent4Page({@required this.args});

  @override
  _NewEvent4PageState createState() => _NewEvent4PageState();
}

class _NewEvent4PageState extends State<NewEvent4Page> {
  NewEventVM _newEvent;

  // Functions

  @override
  void initState() {
    super.initState();
    setState(() {
      _newEvent = widget.args.newEvent;
    });
  }

  // Widgets

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: AppColors.orange),
          shadowColor: Colors.transparent,
          brightness: Brightness.light,
        ),
        body: Center(
          child: Text(_newEvent.addressAttributes['street']),
        ),
      );
    });
  }
}
