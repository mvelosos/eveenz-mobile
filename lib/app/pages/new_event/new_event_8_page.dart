import 'package:flutter/material.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

// Page Arguments
class NewEvent8PageArguments {
  final NewEventVM newEvent;

  NewEvent8PageArguments({@required this.newEvent});
}

// Page
class NewEvent8Page extends StatefulWidget {
  final NewEvent8PageArguments args;

  NewEvent8Page({@required this.args});

  @override
  _NewEvent8PageState createState() => _NewEvent8PageState();
}

class _NewEvent8PageState extends State<NewEvent8Page> {
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
            child: Text('so tireedddd'),
          ),
        );
      },
    );
  }
}
