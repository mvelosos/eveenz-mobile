import 'package:flutter/material.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class NewEventPage extends StatefulWidget {
  @override
  _NewEventPageState createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: AppColors.orange),
            shadowColor: Colors.transparent,
            brightness: Brightness.light,
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Text('new event'),
          ),
        );
      },
    );
  }
}
