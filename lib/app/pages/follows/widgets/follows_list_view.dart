import 'package:flutter/material.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/pages/follows/widgets/follows_account_list_tile.dart';

class FollowsListView extends StatelessWidget {
  final Function _reloadFollows;
  final List<AccountModel> _list;

  FollowsListView(this._list, this._reloadFollows);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _reloadFollows();
      },
      child: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (_, idx) {
          if (_list != null && _list.length > 0) {
            return FollowsAccountListTile(_list[idx]);
          }
          return null;
        },
      ),
    );
  }
}
