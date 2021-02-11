import 'package:flutter/material.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

// Page Arguments
class NewEvent3PageArguments {
  final NewEventVM newEvent;

  NewEvent3PageArguments({@required this.newEvent});
}

// Page
class NewEvent3Page extends StatefulWidget {
  final NewEvent3PageArguments args;

  NewEvent3Page({@required this.args});

  @override
  _NewEvent3PageState createState() => _NewEvent3PageState();
}

class _NewEvent3PageState extends State<NewEvent3Page> {
  NavigationService _navigationService;
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
    _navigationService = NavigationService.currentNavigator(context);

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
            child: Text(_newEvent.privacy),
          ),
        );
      },
    );
  }
}
