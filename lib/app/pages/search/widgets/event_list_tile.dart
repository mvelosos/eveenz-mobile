import 'package:flutter/material.dart';
import 'package:party_mobile/app/pages/event/event_page.dart';
import 'package:party_mobile/app/pages/search/widgets/tile_image.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class EventListTile extends StatelessWidget {
  final _item;

  EventListTile(this._item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TileImage(_item),
      title: Text(_item.name),
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteNames.showEvent,
          arguments: EventPageArguments(uuid: _item.uuid),
        );
      },
    );
  }
}
