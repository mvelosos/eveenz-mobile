import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_mobile/app/models/account_follow_model.dart';
import 'package:party_mobile/app/pages/follows/widgets/follows_account_list_tile.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/view_models/search_vm.dart';

class FollowsListView extends StatefulWidget {
  final Function _reloadFollows;
  final List<AccountFollowModel> _list;

  FollowsListView(this._list, this._reloadFollows);

  @override
  _FollowsListViewState createState() => _FollowsListViewState();
}

class _FollowsListViewState extends State<FollowsListView> {
  final TextEditingController _searchInputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final SearchVM _search = SearchVM();

  Widget _searchTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 40,
        child: TextField(
          controller: _searchInputController,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          onChanged: (value) {
            setState(() {
              _search.query = value;
            });
            widget._reloadFollows(_search);
          },
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: AppColors.gray3,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.grayLight,
            contentPadding: const EdgeInsets.all(0),
            labelText: 'Pesquisar',
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.gray3,
            ),
            suffixIcon: Visibility(
              visible: _search.query.length > 0,
              child: IconButton(
                onPressed: () => {
                  _searchInputController.clear(),
                  _search.query = '',
                  widget._reloadFollows()
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidTimesCircle,
                  color: AppColors.gray3,
                  size: 18,
                ),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
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
    );
  }

  Widget _noResultsText() {
    return ListTile(
      dense: true,
      title: Text(
        'Nenhum usuário encontrado',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.gray3,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  List<Widget> _getListItems(BuildContext context) {
    List<Widget> _listWidgets = [];
    _listWidgets.add(_searchTextField(context));

    if (widget._list.isNotEmpty) {
      widget._list.forEach((element) {
        _listWidgets.add(FollowsAccountListTile(element));
      });
    } else {
      _listWidgets.add(_noResultsText());
    }

    return _listWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await widget._reloadFollows();
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scrollbar(
          child: ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: _getListItems(context).length,
            itemBuilder: (_, idx) {
              return _getListItems(_)[idx];
            },
          ),
        ),
      ),
    );
  }
}
