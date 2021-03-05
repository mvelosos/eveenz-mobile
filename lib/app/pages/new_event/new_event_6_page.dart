import 'package:flutter/material.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

// Page Arguments
class NewEvent6PageArguments {
  final NewEventVM newEvent;

  NewEvent6PageArguments({@required this.newEvent});
}

// Page
class NewEvent6Page extends StatefulWidget {
  final NewEvent6PageArguments args;

  NewEvent6Page({@required this.args});

  @override
  _NewEvent6PageState createState() => _NewEvent6PageState();
}

class _NewEvent6PageState extends State<NewEvent6Page> {
  NewEventVM _newEvent;

  // Functions

  @override
  void initState() {
    super.initState();
    setState(() {
      _newEvent = widget.args.newEvent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: AppColors.orange),
            shadowColor: Colors.transparent,
            brightness: Brightness.light,
          ),
          body: Center(
            child: Text('next page'),
          ),
        );
      },
    );
  }
}
