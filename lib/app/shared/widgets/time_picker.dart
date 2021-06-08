import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePicker {
  BuildContext? _context;
  DateTime? _selectedTime;
  Function? _setTime;

  TimePicker(context, selectedDate, setTime) {
    this._context = context;
    this._selectedTime = selectedDate;
    this._setTime = setTime;
    this._selectTime();
  }

  _selectTime() async {
    if (Platform.isIOS) {
      return _buildCupertinoTimePicker(_context!);
    } else {
      return _buildMaterialTimePicker(_context!);
    }
  }

  _buildMaterialTimePicker(BuildContext context) async {
    TimeOfDay _currentTime = TimeOfDay.fromDateTime(_selectedTime!);
    final picked =
        await showTimePicker(context: context, initialTime: _currentTime);
    if (picked != null && picked != _currentTime) {
      DateTime date = DateTime.now();
      DateTime newTime =
          DateTime(date.year, date.month, date.day, picked.hour, picked.minute);
      _setTime!(newTime);
    }
  }

  _buildCupertinoTimePicker(BuildContext context) async {
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
                onDateTimeChanged: (picked) {
                  if (picked != null && picked != _selectedTime)
                    _setTime!(picked);
                },
                use24hFormat: true,
                initialDateTime: _selectedTime,
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
}
