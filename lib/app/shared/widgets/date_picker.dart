import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker {
  BuildContext? _context;
  DateTime? _selectedDate;
  Function? _setDate;

  DatePicker(context, selectedDate, setDate) {
    this._context = context;
    this._selectedDate = selectedDate;
    this._setDate = setDate;
    this._selectDate();
  }

  _selectDate() {
    if (Platform.isIOS) {
      return buildCupertinoDatePicker(_context!);
    } else {
      return buildMaterialDatePicker(_context!);
    }
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) _setDate!(picked);
  }

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
                  if (picked != _selectedDate) _setDate!(picked);
                },
                initialDateTime: _selectedDate,
                minimumYear: DateTime.now().year,
                maximumYear: DateTime.now().year + 2,
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
