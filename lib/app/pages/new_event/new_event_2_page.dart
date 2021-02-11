import 'package:flutter/material.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

// Page Arguments
class NewEvent2PageArguments {
  final NewEventVM newEvent;

  NewEvent2PageArguments({@required this.newEvent});
}

// Page
class NewEvent2Page extends StatefulWidget {
  final NewEvent2PageArguments args;

  NewEvent2Page({@required this.args});

  @override
  _NewEvent2PageState createState() => _NewEvent2PageState();
}

class _NewEvent2PageState extends State<NewEvent2Page> {
  NewEventVM _newEvent;

  @override
  void initState() {
    super.initState();
    _newEvent = widget.args.newEvent;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: AppColors.orange),
            shadowColor: Colors.transparent,
            brightness: Brightness.light,
          ),
          body: Center(
            child: Text(_newEvent.name),
          ),
        );
      },
    );
  }
}
