import 'package:flutter/material.dart';
import 'package:party_mobile/app/models/search_result_model.dart';
import 'package:party_mobile/app/pages/search/widgets/account_list_tile.dart';
import 'package:party_mobile/app/pages/search/widgets/event_list_tile.dart';

class SearchListView extends StatelessWidget {
  final SearchResultModel resultSearch;

  SearchListView(this.resultSearch);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: resultSearch.data != null ? resultSearch.data.length : 0,
      itemBuilder: (_, idx) {
        if (resultSearch.data != null && resultSearch.data.length > 0) {
          return resultSearch.data[idx].type == 'account'
              ? AccountListTile(resultSearch.data[idx])
              : EventListTile(resultSearch.data[idx]);
        }
        return null;
      },
    );
  }
}
