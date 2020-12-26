import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/pages/account/account_page.dart';
import 'package:party_mobile/app/pages/search/widgets/tile_image.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class AccountListTile extends StatelessWidget {
  final _item;
  final _searchNavigator =
      NavigationService(locator<SearchNavigatorKey>().navigatorKey);

  AccountListTile(this._item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TileImage(_item),
      title: Text(_item.name),
      subtitle: Text(_item.username),
      onTap: () {
        _searchNavigator.pushNamed(
          RouteNames.showUser,
          arguments: AccountPageArguments(username: _item.username),
        );
      },
    );
  }
}
