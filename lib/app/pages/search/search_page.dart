import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/search_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/search_result_model.dart';
import 'package:party_mobile/app/pages/search/widgets/search_list_view.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/view_models/search_vm.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchController = locator<SearchController>();
  var _searchInputController = TextEditingController();
  var _search = SearchVM();
  var _resultSearch = SearchResultModel();
  var _focusNode = FocusNode();

  List _categoryItems = [
    {'name': 'Sertanejo', 'color': Color(0xFF440AE9)},
    {'name': 'Funk', 'color': Color(0xFF68D273)},
    {'name': 'Pop', 'color': Color(0xFFC989E1)},
    {'name': 'Rock', 'color': Color(0xFFFC8339)},
    {'name': 'Happy Hour', 'color': Color(0xFF2F80ED)},
    {'name': 'Ar Livre', 'color': Color(0xFFAB5687)},
    {'name': 'Tango', 'color': Color(0xFFa7FABC)},
    {'name': 'Balada', 'color': Color(0xFF9BF7F2)},
  ];

  // Functions

  void _requestSearch() async {
    var result = await _searchController.search(_search);
    result.fold(
        (l) => null,
        (r) => {
              setState(() {
                _resultSearch = r;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Descobrir',
          style: GoogleFonts.inter(
            fontSize: size.height * .03,
            color: AppColors.darkPurple,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarOpacity: 1,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              _resultSearch.listData = [];
              _searchInputController.clear();
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(left: 10, right: 10),
              height: constraints.maxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: TextField(
                              controller: _searchInputController,
                              textInputAction: TextInputAction.search,
                              focusNode: _focusNode,
                              onChanged: (value) {
                                _search.query = value;
                                _requestSearch();
                              },
                              autocorrect: false,
                              enableSuggestions: false,
                              cursorColor: AppColors.gray3,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.grayLight,
                                contentPadding: EdgeInsets.only(
                                  bottom: 10,
                                  top: 10,
                                  left: 10,
                                ),
                                labelText: 'Buscar por eventos ou pessoas',
                                suffixIcon:
                                    _searchInputController.text.length > 0 ||
                                            _focusNode.hasFocus
                                        ? IconButton(
                                            onPressed: () => {
                                              _searchInputController.clear(),
                                              _focusNode.unfocus()
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.solidTimesCircle,
                                              color: AppColors.gray3,
                                              size: 18,
                                            ),
                                          )
                                        : Icon(null),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.orange,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () => {},
                              icon: FaIcon(
                                FontAwesomeIcons.slidersH,
                                color: Colors.white,
                                // size: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  _focusNode.hasFocus
                      ? Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: _resultSearch.listData!.isNotEmpty
                                ? SearchListView(_resultSearch)
                                : Container(
                                    height: double.infinity,
                                    color: Colors.blue),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25),
                            Text(
                              'Quero curtir',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 90,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: _categoryItems.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(width: 15),
                                itemBuilder: (context, idx) => TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                  ),
                                  onPressed: () => {
                                    print(_categoryItems[idx]['name']),
                                  },
                                  child: Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: _categoryItems[idx]['color'],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _categoryItems[idx]['name'],
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
