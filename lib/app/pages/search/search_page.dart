import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:party_mobile/app/controllers/search_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/search_result_model.dart';
import 'package:party_mobile/app/pages/search/widgets/search_list_view.dart';
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
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              _resultSearch.data = [];
              _searchInputController.clear();
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(left: 10, right: 10),
              height: constraints.maxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buscar',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: _searchInputController,
                      focusNode: _focusNode,
                      onChanged: (value) {
                        _search.query = value;
                        _requestSearch();
                      },
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: 'Buscar por eventos ou pessoas',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _focusNode.hasFocus
                      ? Expanded(
                          child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: SearchListView(_resultSearch)),
                        )
                      : Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            color: Colors.blue,
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
