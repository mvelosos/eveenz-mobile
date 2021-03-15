import 'package:auto_size_text/auto_size_text.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/categories_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/category_model.dart';
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
  CategoriesController _categoriesController = locator<CategoriesController>();
  List<CategoryModel> _categories;
  List<String> _selectedCategoriesIds;

  // Functions

  @override
  void initState() {
    super.initState();
    setState(() {
      _newEvent = widget.args.newEvent;
    });
    _getCategories();
  }

  _getCategories() async {
    var result = await _categoriesController.getCategories();
    if (result.isRight()) {
      setState(() {
        _categories = result.getOrElse(null);
      });
    }
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
                    'Você pode escolher até 3 categorias que mais combinam com o seu evento',
                    style: GoogleFonts.poppins(
                      fontSize: size.height * .016,
                      color: AppColors.darkPurple,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  ChipsChoice<String>.multiple(
                    value: _selectedCategoriesIds,
                    onChanged: (val) {
                      if (val.length > 3) return;
                      setState(() {
                        _selectedCategoriesIds = val;
                      });

                      print(_selectedCategoriesIds);
                    },
                    choiceItems: C2Choice.listFrom<String, CategoryModel>(
                      source: _categories,
                      value: (i, v) => _categories[i].id.toString(),
                      label: (i, v) => _categories[i].titleizedName,
                    ),
                    wrapped: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    choiceStyle: C2ChoiceStyle(elevation: 4),
                    choiceActiveStyle: C2ChoiceStyle(color: AppColors.orange),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
