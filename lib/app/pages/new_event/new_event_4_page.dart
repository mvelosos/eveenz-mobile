import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  DateTime selectedDate = DateTime.now();
  DateTime selectedTime = DateTime.now();

  // Functions

  @override
  void initState() {
    super.initState();
    setState(() {
      _newEvent = widget.args.newEvent;
    });
  }

  _selectDate(BuildContext context) async {
    if (Platform.isIOS) {
      return buildCupertinoDatePicker(context);
    } else {
      return buildMaterialDatePicker(context);
    }
  }

  _selectTime(BuildContext context) async {
    if (Platform.isIOS) {
      return buildCupertinoTimePicker(context);
    } else {
      return buildMaterialTimePicker(context);
    }
  }

  buildMaterialTimePicker(BuildContext context) async {
    // TimeOfDay time =
    //     TimeOfDay(hour: selectedTime.hour, minute: selectedTime.minute);
    // showTimePicker(context: context, initialTime: time);
  }

  buildCupertinoTimePicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          color: Colors.white,
          child: Stack(
            children: [
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                minuteInterval: 5,
                onDateTimeChanged: (picked) {
                  if (picked != null && picked != selectedDate)
                    setState(() {
                      selectedDate = picked;
                    });
                },
                use24hFormat: true,
                initialDateTime: selectedDate,
              ),
              Positioned(
                right: 0,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          color: Colors.white,
          child: Stack(
            children: [
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (picked) {
                  if (picked != null && picked != selectedDate)
                    setState(() {
                      selectedDate = picked;
                    });
                },
                initialDateTime: selectedDate,
                minimumYear: 2000,
                maximumYear: 2025,
                minimumDate: selectedDate,
              ),
              Positioned(
                right: 0,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Widgets

  Widget _continueButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {},
      child: Container(
        width: _size.width,
        margin: EdgeInsets.symmetric(vertical: _size.height * .007),
        padding: EdgeInsets.symmetric(vertical: _size.height * .024),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: AppColors.orange,
        ),
        child: Text(
          'CONTINUAR',
          style: GoogleFonts.roboto(
            fontSize: _size.height * .015,
            color: Colors.white,
            letterSpacing: 4,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: AppColors.orange),
            shadowColor: Colors.transparent,
            brightness: Brightness.light,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              constraints: BoxConstraints.expand(),
              color: Colors.transparent,
              padding: EdgeInsets.only(
                left: size.width * .08,
                right: size.width * .08,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * .02),
                  Text(
                    'Quando começa?',
                    style: GoogleFonts.inter(
                      fontSize: size.height * .033,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkPurple,
                    ),
                  ),
                  SizedBox(height: size.height * .005),
                  AutoSizeText(
                    'Precisamos saber da data e hora de início do seu evento',
                    style: GoogleFonts.poppins(
                      fontSize: size.height * .016,
                      color: AppColors.darkPurple,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          RaisedButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                              'Select date',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.greenAccent,
                          ),
                          Text(selectedDate.toString()),
                          RaisedButton(
                            onPressed: () => _selectTime(context),
                            child: Text(
                              'Select Time',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.greenAccent,
                          ),
                          Text(selectedTime.toString()),
                        ],
                      ),
                    ),
                  ),
                  _continueButton(context),
                  SizedBox(height: size.height * .01),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
