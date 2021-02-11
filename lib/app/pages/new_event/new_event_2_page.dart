import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/pages/new_event/new_event_3_page.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';

// Page Arguments
class NewEvent2PageArguments {
  final NewEventVM newEvent;

  NewEvent2PageArguments({@required this.newEvent});
}

// Page
class NewEvent2Page extends StatefulWidget {
  final NewEvent2PageArguments args;

  NewEvent2Page({@required this.args});

  @override
  _NewEvent2PageState createState() => _NewEvent2PageState();
}

class _NewEvent2PageState extends State<NewEvent2Page> {
  NavigationService _navigationService;
  NewEventVM _newEvent;
  String _publicDescription = 'Seu evento será visível e disponível para todos';
  String _privateDescription =
      'Seu evento será visível porém a localização só será mostrada após você permitir a presença do usuário';
  String _secretDescription =
      'Seu evento não será visiível. Apenas usuários convidados poderão ter acesso';

  // Functions

  @override
  void initState() {
    super.initState();
    setState(() {
      _newEvent = widget.args.newEvent;
      _newEvent.privacy = 'public';
    });
  }

  // Widgets

  Widget _radioButton(BuildContext context, String radioName, String radioValue,
      String radioDescription) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          _newEvent.privacy = radioValue;
        });
      },
      child: Container(
        padding: EdgeInsets.only(
          top: _size.height * .021,
          bottom: _size.height * .021,
          left: _size.height * .016,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: _newEvent.privacy == radioValue
                ? AppColors.purple
                : AppColors.grayLight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: radioValue,
                    groupValue: _newEvent.privacy,
                    onChanged: (value) {
                      setState(() {
                        _newEvent.privacy = radioValue;
                      });
                    },
                    activeColor: AppColors.orange,
                  ),
                ),
                AutoSizeText(
                  radioName,
                  maxFontSize: 19,
                  style: GoogleFonts.inter(
                    fontSize: 19,
                    color: AppColors.darkPurple,
                    fontWeight: _newEvent.privacy == radioValue
                        ? FontWeight.bold
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
            _newEvent.privacy == radioValue
                ? Container(
                    padding: EdgeInsets.only(left: 45, right: 5),
                    child: AutoSizeText(
                      radioDescription,
                      maxLines: 3,
                      style: GoogleFonts.poppins(),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _navigationService.pushNamed(
          RouteNames.newEvent3,
          arguments: NewEvent3PageArguments(newEvent: _newEvent),
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
              padding: EdgeInsets.only(
                left: size.width * .08,
                right: size.width * .08,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * .02),
                  Text(
                    'Como vai ser?',
                    style: GoogleFonts.inter(
                      fontSize: size.height * .035,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkPurple,
                    ),
                  ),
                  SizedBox(height: size.height * .005),
                  AutoSizeText(
                    'Escolha qual vai ser o tipo de privacidade do seu evento',
                    style: GoogleFonts.poppins(
                      fontSize: size.height * .016,
                      color: AppColors.darkPurple,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _radioButton(
                            context, 'Público', 'public', _publicDescription),
                        _radioButton(
                            context, 'Privado', 'private', _privateDescription),
                        _radioButton(
                            context, 'Secreto', 'secret', _secretDescription),
                      ],
                    ),
                  ),
                  _continueButton(context),
                  SizedBox(height: size.height * .02),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
