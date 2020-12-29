import 'package:flutter/material.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/pages/follows/widgets/follows_list_view.dart';

class FollowsTabView extends StatelessWidget {
  final BoxConstraints constraints;
  final Function getFollowers;
  final Function getFollowing;
  final List<AccountModel> followersList;
  final List<AccountModel> followingList;

  FollowsTabView(
      {@required this.constraints,
      @required this.followersList,
      @required this.followingList,
      @required this.getFollowers,
      @required this.getFollowing});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        FollowsListView(followersList, getFollowers),
        FollowsListView(followingList, getFollowing),
      ],
    );
  }
}
