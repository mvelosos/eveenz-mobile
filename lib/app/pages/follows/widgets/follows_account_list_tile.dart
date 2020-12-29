import 'package:flutter/material.dart';
import 'package:party_mobile/app/pages/account/account_page.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class FollowsAccountListTile extends StatelessWidget {
  final _item;

  FollowsAccountListTile(this._item);

  // Widgets
  Widget _followAccountTileImage() {
    return _item.avatarUrl != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              _item.avatarUrl,
              height: 50,
              width: 50,
            ),
          )
        : CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue,
          );
  }

  @override
  Widget build(BuildContext context) {
    final _navigationService = NavigationService.currentNavigator(context);

    return ListTile(
      leading: _followAccountTileImage(),
      title: Text(_item.name),
      subtitle: Text(_item.username),
      onTap: () {
        _navigationService.pushNamed(
          RouteNames.showAccount,
          arguments: AccountPageArguments(username: _item.username),
        );
      },
    );
  }
}
