import 'package:flutter/material.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/pages/follows/widgets/follows_list_view.dart';

class FollowsTabView extends StatefulWidget {
  final List<AccountModel> followersList;
  final List<AccountModel> followingList;
  final BoxConstraints constraints;

  FollowsTabView(
      {@required this.followersList,
      @required this.followingList,
      @required this.constraints});

  @override
  _FollowsTabViewState createState() => _FollowsTabViewState();
}

class _FollowsTabViewState extends State<FollowsTabView> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        FollowsListView(widget.followersList),
        FollowsListView(widget.followingList),
      ],
    );
  }
}
