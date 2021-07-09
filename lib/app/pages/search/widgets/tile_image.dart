import 'package:flutter/material.dart';

class TileImage extends StatelessWidget {
  final _item;

  TileImage(this._item);

  @override
  Widget build(BuildContext context) {
    var _url = _item.type == 'account' ? _item.avatarUrl : _item.imageUrl;

    return _url != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              _url,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          )
        : CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
          );
  }
}
