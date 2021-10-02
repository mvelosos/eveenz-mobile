import 'package:flutter/material.dart';
import 'package:party_mobile/app/models/search_result_model.dart';
import 'package:party_mobile/app/pages/search/widgets/account_list_tile.dart';
import 'package:party_mobile/app/pages/search/widgets/event_list_tile.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class SearchListView extends StatelessWidget {
  final SearchResultModel resultSearch;

  SearchListView(this.resultSearch);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            child: TabBar(
              labelColor: Colors.black,
              indicatorColor: AppColors.gray4,
              tabs: [
                Tab(text: 'Todos'),
                Tab(text: 'Eventos'),
                Tab(text: 'Pessoas'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: size.height - 500,
            child: TabBarView(
              children: <Widget>[
                // Render all results
                ListView.builder(
                  itemCount:
                      resultSearch.all != null ? resultSearch.all?.length : 0,
                  itemBuilder: (_, idx) {
                    if (resultSearch.all != null &&
                        resultSearch.all!.length > 0) {
                      return resultSearch.all?[idx]?.type == 'account'
                          ? AccountListTile(resultSearch.all?[idx])
                          : EventListTile(resultSearch.all?[idx]);
                    }
                    return SizedBox.shrink();
                  },
                ),
                // Render events results
                ListView.builder(
                  itemCount:
                      resultSearch.all != null ? resultSearch.all?.length : 0,
                  itemBuilder: (_, idx) {
                    if (resultSearch.all != null &&
                        resultSearch.all!.length > 0 &&
                        resultSearch.all?[idx]?.type == 'event') {
                      return EventListTile(resultSearch.all?[idx]);
                    }
                    return SizedBox.shrink();
                  },
                ),
                // Render accounts results
                ListView.builder(
                  itemCount:
                      resultSearch.all != null ? resultSearch.all?.length : 0,
                  itemBuilder: (_, idx) {
                    if (resultSearch.all != null &&
                        resultSearch.all!.length > 0 &&
                        resultSearch.all?[idx]?.type == 'account') {
                      return AccountListTile(resultSearch.all?[idx]);
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
