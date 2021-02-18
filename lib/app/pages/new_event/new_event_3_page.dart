import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
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
  List<dynamic> _placesSearchResult = [];

  // Functions

  @override
  void initState() {
    super.initState();
    setState(() {
      _newEvent = widget.args.newEvent;
    });
  }

  void _searchGoogleResults(String searchText) async {
    if (searchText.isEmpty) return;
    print(searchText);

    var result = await GooglePlacesService.getSearchResults(searchText);
    setState(() {
      _placesSearchResult = result;
    });

    print(result);
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
                                    title: AutoSizeText(
                                      _placesSearchResult[idx]
                                          ['formatted_address'],
                                      maxLines: 2,
                                      // wrapWords: true,
                                      // softWrap: true,
                                    ),
                                    leading: Icon(Icons.place),
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
