import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/services/google_places_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
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
  NavigationService _navigationService;
  NewEventVM _newEvent;
  String _googleSessionToken;
  List<dynamic> _placesSearchResult = [];

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

  void _searchGoogleResults(String searchText) async {
    if (_googleSessionToken == null) {
      _setSessionToken();
      print(_googleSessionToken);
    }
    if (searchText.isEmpty) return;
    var results = await GooglePlacesService.getPlacesAutocomplete(
        searchText, _googleSessionToken);

    _sanitizeAndSetResults(results);
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
                  TextFormField(
                    onChanged: (value) {
                      _searchGoogleResults(value);
                    },
                    autocorrect: false,
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
                    ),
                  ),
                  SizedBox(height: size.height * .01),
                  Stack(
                    children: [
                      Container(
                        child: _placesSearchResult.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: _placesSearchResult.length,
                                itemBuilder: (_, idx) {
                                  return ListTile(
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
                                            _placesSearchResult[idx]
                                                    ['structured_formatting']
                                                ['secondary_text'],
                                            maxLines: 2,
                                            minFontSize: 13,
                                          )
                                        : null,
                                  );
                                },
                              )
                            : SizedBox.shrink(),
                      ),
                    ],
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
