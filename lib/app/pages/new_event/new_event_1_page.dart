import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/pages/new_event/new_event_2_page.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

class NewEvent1Page extends StatefulWidget {
  @override
  _NewEvent1PageState createState() => _NewEvent1PageState();
}

class _NewEvent1PageState extends State<NewEvent1Page> {
  final _formKey = GlobalKey<FormState>();
  final _newEvent = NewEventVM();
  NavigationService _navigationService;

  // Widgets

  Widget _formInput(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
          labelText: 'Qual o nome do seu evento?',
          labelStyle: GoogleFonts.inter(
            color: AppColors.darkPurple,
            fontWeight: FontWeight.bold,
            fontSize: size.height * .017,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.orange),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value.isEmpty) return "O evento precisa de um nome!";
          if (value.length > 60)
            return "O nome só pode ter no máximo 60 caracteres";
          return null;
        },
        onChanged: (value) {
          setState(() {
            _newEvent.name = value;
          });
        },
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _navigationService.pushNamed(
            RouteNames.newEvent2,
            arguments: NewEvent2PageArguments(newEvent: _newEvent),
          );
        }
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
              padding: EdgeInsets.only(
                left: size.width * .08,
                right: size.width * .08,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * .02),
                  Text(
                    'Criar evento',
                    style: GoogleFonts.inter(
                      fontSize: size.height * .04,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkPurple,
                    ),
                  ),
                  SizedBox(height: size.height * .005),
                  Text(
                    'Vamos precisar de algumas informações sobre seu evento',
                    style: GoogleFonts.poppins(
                      fontSize: size.height * .016,
                      color: AppColors.darkPurple,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: _formInput(context),
                    ),
                  ),
                  _continueButton(context),
                  SizedBox(height: size.height * .04),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
