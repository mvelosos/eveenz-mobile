import 'package:auto_size_text/auto_size_text.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/categories_controller.dart';
import 'package:party_mobile/app/controllers/request_categories_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/category_model.dart';
import 'package:party_mobile/app/pages/new_event/new_event_8_page.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';
import 'package:party_mobile/app/view_models/new_request_category_vm.dart';

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
  RequestCategoriesController _requestCategoriesController =
      locator<RequestCategoriesController>();
  List<CategoryModel> _categories = [];
  List<String> _selectedCategoriesIds = [];
  NewRequestCategoryVM _newRequestCategory = NewRequestCategoryVM();
  TextEditingController _newRequestCategoryController =
      TextEditingController(text: '');

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

  _requestNewRequestCategory(BuildContext context) async {
    var result = await _requestCategoriesController
        .newRequestCategory(_newRequestCategory);
    result.fold(
      (l) => {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Ops, tente novamente mais tarde!',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            backgroundColor: AppColors.snackWarning,
            behavior: SnackBarBehavior.floating,
          ),
        )
      },
      (r) => {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Recebemos sua sugestão! Entraremos em contato caso sua sugestão for aceita',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.blue,
            behavior: SnackBarBehavior.floating,
          ),
        )
      },
    );
  }

  // Widgets

  Widget _continueButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _newEvent.eventCategories = [];
        if (_selectedCategoriesIds.length > 0) {
          _selectedCategoriesIds.forEach((categoryId) {
            var data = {'categoryId': categoryId};
            _newEvent.eventCategories.add(data);
          });
        }

        print(_newEvent.getData());
        _navigationService.pushNamed(
          RouteNames.newEvent8,
          arguments: NewEvent8PageArguments(newEvent: _newEvent),
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
                      padding: EdgeInsets.only(top: 10),
                      choiceStyle: C2ChoiceStyle(elevation: 4),
                      choiceActiveStyle: C2ChoiceStyle(color: AppColors.orange),
                    ),
                    SizedBox(height: size.height * .04),
                    TextFormField(
                      controller: _newRequestCategoryController,
                      onChanged: (value) {
                        setState(() {
                          _newRequestCategory.name = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Não encontrou sua categoria ideal?',
                        hintText: 'Que tal sugerir uma nova?',
                        hintStyle: TextStyle(fontSize: size.height * .015),
                        labelStyle: GoogleFonts.inter(
                          color: AppColors.darkPurple,
                          fontSize: size.height * .018,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.orange,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          if (_newRequestCategory.name.isNotEmpty) {
                            _requestNewRequestCategory(context);
                            setState(() {
                              _newRequestCategoryController.text = '';
                              _newRequestCategory.name = '';
                            });
                          }
                        },
                        child: Text('Enviar'),
                      ),
                    ),
                    SizedBox(height: size.height * .05),
                    _continueButton(context)
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
