import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/pages/new_event/new_event_7_page.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
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
  NavigationService _navigationService;
  bool _restrictedAge = false;
  double _minimumAge = 18;

  // Functions

  @override
  void initState() {
    super.initState();
    setState(() {
      _newEvent = widget.args.newEvent;
    });
  }

  // Widgets

  Widget _continueButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        if (_restrictedAge) {
          _newEvent.minimumAge = _minimumAge.toInt();
        }
        _navigationService.pushNamed(
          RouteNames.newEvent7,
          arguments: NewEvent7PageArguments(newEvent: _newEvent),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * .02),
                    Text(
                      'Sobre o evento',
                      style: GoogleFonts.inter(
                        fontSize: size.height * .033,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkPurple,
                      ),
                    ),
                    SizedBox(height: size.height * .005),
                    AutoSizeText(
                      'É hora de nos dar mais detalhes sobre seu evento',
                      style: GoogleFonts.poppins(
                        fontSize: size.height * .016,
                        color: AppColors.darkPurple,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: size.height * .02),
                          TextFormField(
                            onChanged: (value) {
                              _newEvent.description = value;
                            },
                            maxLines: null,
                            maxLength: 250,
                            decoration: InputDecoration(
                              labelText: 'Descreva seu evento',
                              labelStyle: GoogleFonts.inter(
                                  color: AppColors.darkPurple,
                                  fontSize: size.height * .018,
                                  fontWeight: FontWeight.bold),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.orange,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * .02),
                          SwitchListTile(
                            value: _restrictedAge,
                            onChanged: (value) {
                              setState(() {
                                if (!value) {
                                  _newEvent.minimumAge = null;
                                }
                                _restrictedAge = value;
                              });
                            },
                            contentPadding: EdgeInsets.all(0),
                            activeColor: AppColors.orange,
                            title: Text('Restrição de idade?'),
                          ),
                          SizedBox(height: size.height * .005),
                          _restrictedAge
                              ? Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        _minimumAge.toInt().toString(),
                                        style: TextStyle(
                                          fontSize: size.height * .03,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * .02),
                                    Slider.adaptive(
                                      value: _minimumAge,
                                      onChanged: (value) {
                                        setState(() {
                                          _minimumAge = value;
                                        });
                                      },
                                      max: 25,
                                      min: 12,
                                      divisions: 13,
                                      activeColor: AppColors.orange,
                                    )
                                  ],
                                )
                              : SizedBox.shrink(),
                          SizedBox(height: size.height * .02),
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _newEvent.externalUrl = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Link externo',
                              hintText: 'Ingressos, sites, redes sociais...',
                              labelStyle: GoogleFonts.inter(
                                  color: AppColors.darkPurple,
                                  fontSize: size.height * .018,
                                  fontWeight: FontWeight.bold),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.orange,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * .05),
                    _continueButton(context),
                    SizedBox(height: size.height * .01),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
