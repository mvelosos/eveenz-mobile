import 'package:flutter/material.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/pages/follows/widgets/follows_account_list_tile.dart';

class FollowsListView extends StatelessWidget {
  final List<AccountModel> list;

  FollowsListView(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, idx) {
        if (list != null && list.length > 0) {
          return FollowsAccountListTile(list[idx]);
        }
        return null;
      },
    );
  }
}
