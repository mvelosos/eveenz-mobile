import 'package:flutter/material.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

// Page Arguments
class NewEvent7PageArguments {
  final NewEventVM newEvent;

  NewEvent7PageArguments({@required this.newEvent});
}

// Page
class NewEvent7Page extends StatefulWidget {
  final NewEvent7PageArguments args;

  NewEvent7Page({@required this.args});

  @override
  _NewEvent7PageState createState() => _NewEvent7PageState();
}

class _NewEvent7PageState extends State<NewEvent7Page> {
  NewEventVM _newEvent;
  NavigationService _navigationService;

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
          body: Center(child: Text('next screen')),
        );
      },
    );
  }
}
