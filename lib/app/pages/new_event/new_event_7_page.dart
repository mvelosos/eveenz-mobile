import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              padding: EdgeInsets.only(
                left: size.width * .08,
                right: size.width * .08,
              ),
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
                    'Você pode escolher até 3 categorias que seu evento se encaixa.',
                    style: GoogleFonts.poppins(
                      fontSize: size.height * .016,
                      color: AppColors.darkPurple,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Chip(
                    label: Text(
                      'Aaron Burr',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.pink,
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () {
                      print('deleted');
                    },
                  ),
                  Chip(
                    label: Text(
                      'Joãozin',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () {
                      print('deleted');
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
