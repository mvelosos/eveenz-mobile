import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/categories_controller.dart';
import 'package:party_mobile/app/controllers/request_categories_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/category_model.dart';
import 'package:party_mobile/app/models/image_upload_model.dart';
import 'package:party_mobile/app/services/google_places_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/utils/google_place_details_formatter.dart';
import 'package:party_mobile/app/view_models/new_event_vm.dart';
import 'package:image_picker/image_picker.dart';
import 'package:party_mobile/app/view_models/new_request_category_vm.dart';

class NewEventPage extends StatefulWidget {
  @override
  _NewEventPageState createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _newEvent = NewEventVM();
  final picker = ImagePicker();
  CategoriesController _categoriesController = locator<CategoriesController>();
  RequestCategoriesController _requestCategoriesController =
      locator<RequestCategoriesController>();
  NewRequestCategoryVM _newRequestCategory = NewRequestCategoryVM();
  TextEditingController _newRequestCategoryController =
      TextEditingController(text: '');
  List<CategoryModel> _categories = [];
  List<String> _selectedCategoriesIds = [];
  List<Object> images = List<Object>();
  Future<PickedFile> _imageFile;
  String _googleSessionToken;
  List<dynamic> _placesSearchResult = [];
  Map _selectedPlace;
  TextEditingController _inputTextController = TextEditingController(text: '');

  // Functions
  void initState() {
    super.initState();
    _getCategories();
    _newEvent.privacy = 'public';
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
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

  _getCategories() async {
    var result = await _categoriesController.getCategories();
    if (result.isRight()) {
      setState(() {
        _categories = result.getOrElse(null);
      });
    }
  }

  Future getImage() async {
    var pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    print(pickedFile.path);
    pickedFile = null;

    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //   } else {
    //     print('No image selected.');
    //   }
    // });
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = picker.getImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void _setEventCategories() {
    _newEvent.eventCategories = [];
    if (_selectedCategoriesIds.length > 0) {
      _selectedCategoriesIds.forEach((categoryId) {
        var data = {'categoryId': categoryId};
        _newEvent.eventCategories.add(data);
      });
    }
  }

  void getFileImage(int index) async {
    //    var dir = await path_provider.getTemporaryDirectory();
    if (_imageFile != null) {
      _imageFile.then((file) async {
        setState(() {
          ImageUploadModel imageUpload = new ImageUploadModel();
          imageUpload.isUploaded = false;
          imageUpload.uploading = false;
          imageUpload.imageFile = file;
          imageUpload.imageUrl = '';
          images.replaceRange(index, index + 1, [imageUpload]);
        });
      });
    }
  }

  // Widgets
  Widget _radioButton(
      BuildContext context, String radioName, String radioValue) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          _newEvent.privacy = radioValue;
        });
      },
      child: Container(
        padding: EdgeInsets.only(
          right: _size.height * .016,
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
                  scale: 1,
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
                  maxFontSize: 15,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: AppColors.darkPurple,
                    fontWeight: _newEvent.privacy == radioValue
                        ? FontWeight.bold
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getPrivacyDescription() {
    String _publicDescription =
        'Seu evento será visível e disponível para todos';
    String _privateDescription =
        'Seu evento será visível porém a localização só será mostrada após você permitir a presença do usuário';
    String _secretDescription =
        'Seu evento não será visível. Apenas usuários convidados poderão ter acesso';
    String currentDescription;

    switch (_newEvent.privacy) {
      case 'public':
        currentDescription = _publicDescription;
        break;
      case 'private':
        currentDescription = _privateDescription;
        break;
      case 'secret':
        currentDescription = _secretDescription;
        break;
      default:
        currentDescription = '';
    }

    return currentDescription;
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraint) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: AppColors.orange),
            shadowColor: Colors.transparent,
            brightness: Brightness.light,
            automaticallyImplyLeading: false,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              padding: EdgeInsets.only(
                left: _size.width * .08,
                right: _size.width * .08,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Criar evento',
                      style: GoogleFonts.inter(
                        fontSize: _size.height * .04,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkPurple,
                      ),
                    ),
                    SizedBox(height: _size.height * .005),
                    Text(
                      'Vamos precisar de algumas informações sobre seu evento',
                      style: GoogleFonts.poppins(
                        fontSize: _size.height * .016,
                        color: AppColors.darkPurple,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: _size.height * .005),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              labelText: 'Qual o nome?',
                              labelStyle: GoogleFonts.inter(
                                color: AppColors.darkPurple,
                                fontWeight: FontWeight.w600,
                                fontSize: _size.height * .017,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.orange),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty)
                                return "O evento precisa de um nome!";
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
                          SizedBox(height: _size.height * .03),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Privacidade',
                              style: GoogleFonts.inter(
                                color: AppColors.darkPurple,
                                fontWeight: FontWeight.w600,
                                fontSize: _size.height * .017,
                              ),
                            ),
                          ),
                          SizedBox(height: _size.height * .015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _radioButton(context, 'Pública', 'public'),
                              _radioButton(context, 'Privada', 'private'),
                              _radioButton(context, 'Secreta', 'secret')
                            ],
                          ),
                          SizedBox(height: _size.height * .015),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              _getPrivacyDescription(),
                              style: TextStyle(color: AppColors.gray1),
                            ),
                          ),
                          SizedBox(height: _size.height * .04),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Imagens',
                              style: GoogleFonts.inter(
                                color: AppColors.darkPurple,
                                fontWeight: FontWeight.w600,
                                fontSize: _size.height * .017,
                              ),
                            ),
                          ),
                          SizedBox(height: _size.height * .015),
                          Container(
                            child: GridView.count(
                              primary: false,
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              children: List.generate(images.length, (index) {
                                if (images[index] is ImageUploadModel) {
                                  ImageUploadModel uploadModel = images[index];
                                  return Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: <Widget>[
                                        Image.file(
                                          File(uploadModel.imagePath),
                                          width: 300,
                                          height: 300,
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: InkWell(
                                            child: Icon(
                                              Icons.remove_circle,
                                              size: 20,
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                images.replaceRange(index,
                                                    index + 1, ['Add Image']);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Card(
                                    child: IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        // _onAddImageClick(index);
                                      },
                                    ),
                                  );
                                }
                              }),
                            ),
                          ),
                          SizedBox(height: _size.height * .03),
                          TextFormField(
                            onChanged: (value) {
                              _newEvent.description = value;
                            },
                            maxLines: null,
                            maxLength: 250,
                            decoration: InputDecoration(
                              labelText: 'Descrição do evento',
                              labelStyle: GoogleFonts.inter(
                                  color: AppColors.darkPurple,
                                  fontSize: _size.height * .017,
                                  fontWeight: FontWeight.bold),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.orange,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: _size.height * .03),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Categorias',
                                  style: GoogleFonts.inter(
                                    color: AppColors.darkPurple,
                                    fontWeight: FontWeight.w600,
                                    fontSize: _size.height * .017,
                                  ),
                                ),
                                SizedBox(height: _size.height * .005),
                                AutoSizeText(
                                  'Você pode escolher até 3 categorias que mais combinam com o seu evento',
                                )
                              ],
                            ),
                          ),
                          ChipsChoice<String>.multiple(
                            value: _selectedCategoriesIds,
                            onChanged: (val) {
                              if (val.length > 3) return;
                              setState(() {
                                _selectedCategoriesIds = val;
                              });
                            },
                            choiceItems:
                                C2Choice.listFrom<String, CategoryModel>(
                              source: _categories,
                              value: (i, v) => _categories[i].id.toString(),
                              label: (i, v) => _categories[i].titleizedName,
                            ),
                            wrapped: true,
                            padding: EdgeInsets.only(top: 10),
                            choiceStyle: C2ChoiceStyle(elevation: 4),
                            choiceActiveStyle:
                                C2ChoiceStyle(color: AppColors.orange),
                          ),
                          SizedBox(height: _size.height * .03),
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
                              hintStyle:
                                  TextStyle(fontSize: _size.height * .015),
                              labelStyle: GoogleFonts.inter(
                                color: AppColors.darkPurple,
                                fontWeight: FontWeight.w500,
                                fontSize: _size.height * .016,
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
                          SizedBox(height: _size.height * .01),
                          TextFormField(
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                addressInputTextValidator(value),
                            decoration: InputDecoration(
                              labelText: 'Endereço',
                              labelStyle: GoogleFonts.inter(
                                color: AppColors.darkPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: _size.height * .017,
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
                          Stack(
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
                                                _placesSearchResult[idx][
                                                        'structured_formatting']
                                                    ['main_text'],
                                                maxLines: 2,
                                                minFontSize: 15,
                                              ),
                                              subtitle: _placesSearchResult[idx]
                                                          [
                                                          'structured_formatting']
                                                      .containsKey(
                                                          'secondary_text')
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
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: _size.height * .03),
                                            AutoSizeText(
                                              'Confirme o endereço',
                                              style: GoogleFonts.poppins(
                                                fontSize: _size.height * .02,
                                                color: AppColors.orange,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                                height: _size.height * .01),
                                            AutoSizeText(
                                              _selectedPlace['result']
                                                  ['formatted_address'],
                                              style: GoogleFonts.poppins(
                                                fontSize: _size.height * .015,
                                                color: AppColors.darkPurple,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                                height: _size.height * .03),
                                            AutoSizeText(
                                              'Seu endereço tem algum complemento?',
                                              style: GoogleFonts.poppins(
                                                fontSize: _size.height * .018,
                                                color: AppColors.orange,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            TextFormField(
                                              onChanged: (value) {
                                                _newEvent.addressAttributes[
                                                    'complement'] = value;
                                              },
                                              autocorrect: false,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Apartamento, bloco...',
                                                labelStyle: GoogleFonts.inter(
                                                  color: AppColors.darkPurple,
                                                  fontSize: _size.height * .015,
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
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
                          SizedBox(height: _size.height * .1),
                        ],
                      ),
                    )
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
