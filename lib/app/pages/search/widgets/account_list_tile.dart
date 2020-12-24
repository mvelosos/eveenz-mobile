import 'package:flutter/material.dart';
import 'package:party_mobile/app/pages/search/widgets/tile_image.dart';

class AccountListTile extends StatelessWidget {
  final _item;

  AccountListTile(this._item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TileImage(_item),
      title: Text(_item.name),
      subtitle: Text(_item.username),
      onTap: () {
        print(_item.name);
      },
    );
  }
}
