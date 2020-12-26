import 'package:flutter/material.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/pages/search/widgets/tile_image.dart';
import 'package:party_mobile/app/services/navigation_service.dart';

class EventListTile extends StatelessWidget {
  final _item;
  final _searchNavigator =
      NavigationService(locator<SearchNavigatorKey>().navigatorKey);

  EventListTile(this._item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TileImage(_item),
      title: Text(_item.name),
      onTap: () {
        print(_item.name);
      },
    );
  }
}
