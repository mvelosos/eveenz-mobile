import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/pages/new_event/new_event_4_page.dart';
import 'package:party_mobile/app/services/google_places_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/utils/google_place_details_formatter.dart';
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
  final _formKey = GlobalKey<FormState>();
  NavigationService _navigationService;
  NewEventVM _newEvent;
  String _googleSessionToken;
  TextEditingController _inputTextController = TextEditingController(text: '');
  List<dynamic> _placesSearchResult = [];
  Map _selectedPlace;

  // Functions

  @override
  void initState() {
    super.initState();
    setState(() {
      _newEvent = widget.args.newEvent;
    });
  }

  void _setSessionToken() {
    _googleSessionToken = GooglePlacesService.generateSessionToken();
  }

  void _sanitizeAndSetResults(List results) {
    results.removeWhere((item) =>
        !item['structured_formatting'].containsKey('main_text') &&
        !item['structured_formatting'].containsKey('secondary_text'));

    setState(() {
      _placesSearchResult = results;
    });
  }

  /*
   * We need to set a sessionToken, so Google API can group all requests 
   * for billing purposes
   */
  void _getGooglePlaceResults(String searchText) async {
    if (_googleSessionToken == null) {
      _setSessionToken();
    }
    if (searchText.isEmpty) return;
    var results = await GooglePlacesService.getPlacesAutocomplete(
        searchText, _googleSessionToken);

    _sanitizeAndSetResults(results);
  }

  /*
   * After a place is selected, Google invalidates the sessionToken.
   * So we set sessionToken = null and if user search for a place again, a new
   * sessionToken will be generated
   */
  Future<void> _getGooglePlaceDetails(dynamic listItem) async {
    String placeId = listItem['place_id'];
    if (placeId.isNotEmpty) {
      var result = await GooglePlacesService.getPlaceDetails(
          placeId, _googleSessionToken);
      setState(() {
        _selectedPlace = result;
      });
      _setNewEventObject();
    }
    _googleSessionToken = null;
  }

  void _setNewEventObject() {
    Map formattedAddress =
        GooglePlaceDetailsFormatter.formatAddress(_selectedPlace);
    Map formattedLocalization =
        GooglePlaceDetailsFormatter.formatLocalization(_selectedPlace);

    _newEvent.addressAttributes = formattedAddress;
    _newEvent.localizationAttributes = formattedLocalization;
  }

  void _onTapInputTextField() {
    if (_inputTextController.text.isNotEmpty) {
      _getGooglePlaceResults(_inputTextController.text);
    }
  }

  void _onClearTextInputField() {
    _inputTextController.text = '';
    setState(() {
      _placesSearchResult = [];
      _selectedPlace = null;
    });
  }

  void _onTapListTile(dynamic listItem) async {
    _inputTextController.text = listItem['description'];
    setState(() {
      _placesSearchResult = [];
    });
    await _getGooglePlaceDetails(listItem);
    _formKey.currentState.validate();
  }

  dynamic addressInputTextValidator(dynamic value) {
    if (value.isEmpty) return 'O endereço é obrigatório';
    if (_selectedPlace == null) return 'Selecione um endereço para prosseguir';
    if (_newEvent.addressAttributes['number'] == null)
      return 'Seu endereço precisa de um número';
    return null;
  }

  // Widgets

  Widget _continueButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _navigationService.pushNamed(
            RouteNames.newEvent4,
            arguments: NewEvent4PageArguments(newEvent: _newEvent),
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
              _placesSearchResult = [];
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
                    'Onde vai ser?',
                    style: GoogleFonts.inter(
                      fontSize: size.height * .035,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkPurple,
                    ),
                  ),
                  SizedBox(height: size.height * .005),
                  AutoSizeText(
                    'Agora vamos precisar de mais detalhes sobre o endereço do seu evento',
                    style: GoogleFonts.poppins(
                      fontSize: size.height * .016,
                      color: AppColors.darkPurple,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: size.height * .05),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _inputTextController,
                      onTap: () {
                        _onTapInputTextField();
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _getGooglePlaceResults(value);
                        }
                      },
                      autocorrect: false,
                      validator: (value) => addressInputTextValidator(value),
                      decoration: InputDecoration(
                        labelText: 'Endereço',
                        labelStyle: GoogleFonts.inter(
                          color: AppColors.darkPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * .017,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.orange),
                        ),
                        suffixIcon: _inputTextController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _onClearTextInputField();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 17,
                                  color: AppColors.orange,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .01),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          child: _placesSearchResult.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _placesSearchResult.length,
                                  itemBuilder: (_, idx) {
                                    return Container(
                                      child: ListTile(
                                        onTap: () {
                                          _onTapListTile(
                                              _placesSearchResult[idx]);
                                        },
                                        leading: Icon(Icons.place),
                                        title: AutoSizeText(
                                          _placesSearchResult[idx]
                                                  ['structured_formatting']
                                              ['main_text'],
                                          maxLines: 2,
                                          minFontSize: 15,
                                        ),
                                        subtitle: _placesSearchResult[idx]
                                                    ['structured_formatting']
                                                .containsKey('secondary_text')
                                            ? AutoSizeText(
                                                _placesSearchResult[idx][
                                                        'structured_formatting']
                                                    ['secondary_text'],
                                                maxLines: 2,
                                                minFontSize: 13,
                                              )
                                            : null,
                                      ),
                                    );
                                  },
                                )
                              : SizedBox.shrink(),
                        ),
                        _selectedPlace != null &&
                                _placesSearchResult.length == 0 &&
                                _formKey.currentState.validate()
                            ? Container(
                                constraints: BoxConstraints.expand(),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: size.height * .03),
                                      AutoSizeText(
                                        'Confirme o endereço',
                                        style: GoogleFonts.poppins(
                                          fontSize: size.height * .02,
                                          color: AppColors.orange,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(height: size.height * .01),
                                      AutoSizeText(
                                        _selectedPlace['result']
                                            ['formatted_address'],
                                        style: GoogleFonts.poppins(
                                          fontSize: size.height * .015,
                                          color: AppColors.darkPurple,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(height: size.height * .03),
                                      AutoSizeText(
                                        'Seu endereço tem algum complemento?',
                                        style: GoogleFonts.poppins(
                                          fontSize: size.height * .018,
                                          color: AppColors.orange,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextFormField(
                                        onChanged: (value) {
                                          _newEvent.addressAttributes[
                                              'complement'] = value;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Apartamento, bloco...',
                                          labelStyle: GoogleFonts.inter(
                                            color: AppColors.darkPurple,
                                            fontSize: size.height * .015,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.orange,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
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
