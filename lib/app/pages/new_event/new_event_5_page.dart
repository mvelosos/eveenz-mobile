import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:party_mobile/app/pages/new_event/new_event_6_page.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/widgets/date_picker.dart';
import 'package:party_mobile/app/shared/widgets/time_picker.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

// Page Arguments
class NewEvent5PageArguments {
  final NewEventVM newEvent;

  NewEvent5PageArguments({@required this.newEvent});
}

// Page
class NewEvent5Page extends StatefulWidget {
  final NewEvent5PageArguments args;

  NewEvent5Page({@required this.args});

  @override
  _NewEvent5PageState createState() => _NewEvent5PageState();
}

class _NewEvent5PageState extends State<NewEvent5Page> {
  NewEventVM _newEvent;
  NavigationService _navigationService;

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  // Functions

  @override
  void initState() {
    super.initState();
    setState(() {
      _newEvent = widget.args.newEvent;
      _setDate(_selectedDate);
      _setTime(_selectedTime);
    });
  }

  _setDate(DateTime dateTime) {
    String formattedDate = DateFormat('y-MM-dd').format(dateTime);

    setState(() {
      _newEvent.endDate = formattedDate;
      _selectedDate = dateTime;
    });
  }

  _setTime(DateTime dateTime) {
    String formattedTime = DateFormat.Hms().format(dateTime);

    setState(() {
      _newEvent.endTime = formattedTime;
      _selectedTime = dateTime;
    });
  }

  String _getDisplayDate() {
    String formattedDate = DateFormat('dd/MM/y').format(_selectedDate);
    return formattedDate;
  }

  String _getDisplayTime() {
    String formattedTime = DateFormat.Hm().format(_selectedTime);
    return formattedTime;
  }

  _onCheckUndefinedEnd(newValue) {
    setState(() {
      _newEvent.undefinedEnd = newValue;
      if (newValue) {
        _newEvent.endDate = '';
        _newEvent.endTime = '';
      } else {
        _setDate(_selectedDate);
        _setTime(_selectedTime);
      }
    });
  }

  // Widgets

  Widget _continueButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _navigationService.pushNamed(
          RouteNames.newEvent6,
          arguments: NewEvent6PageArguments(newEvent: _newEvent),
        );
      },
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
                    'Quando termina?',
                    style: GoogleFonts.inter(
                      fontSize: size.height * .033,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkPurple,
                    ),
                  ),
                  SizedBox(height: size.height * .005),
                  AutoSizeText(
                    'Precisamos saber da data e hora de término do seu evento',
                    style: GoogleFonts.poppins(
                      fontSize: size.height * .016,
                      color: AppColors.darkPurple,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: size.height * .05),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      child: Column(
                        children: [
                          RawMaterialButton(
                            fillColor: _newEvent.undefinedEnd
                                ? Colors.grey[300]
                                : null,
                            onPressed: () {
                              if (_newEvent.undefinedEnd) return;
                              DatePicker(context, _selectedDate, _setDate);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                left: size.height * .025,
                                top: size.height * .015,
                                right: size.height * .025,
                                bottom: size.height * .015,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.orange),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _getDisplayDate(),
                                style: TextStyle(
                                  fontSize: size.height * .04,
                                  color: AppColors.darkPurple,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * .02),
                          Text(
                            'às',
                            style: TextStyle(
                                fontSize: size.height * .02,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: size.height * .02),
                          RawMaterialButton(
                            fillColor: _newEvent.undefinedEnd
                                ? Colors.grey[300]
                                : null,
                            onPressed: () {
                              if (_newEvent.undefinedEnd) return;
                              TimePicker(context, _selectedTime, _setTime);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                left: size.height * .025,
                                top: size.height * .015,
                                right: size.height * .025,
                                bottom: size.height * .015,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.orange),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _getDisplayTime(),
                                style: TextStyle(
                                  fontSize: size.height * .04,
                                  color: AppColors.darkPurple,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * .05),
                          CheckboxListTile(
                            title:
                                Text("Ainda não sei a data e hora de término"),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: _newEvent.undefinedEnd,
                            onChanged: (newValue) {
                              _onCheckUndefinedEnd(newValue);
                            },
                            activeColor: AppColors.orange,
                            //  <-- leading Checkbox
                          ),
                          Text('Não se preocupe. Você poderá alterar depois')
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
