import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/accounts_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/pages/follows/widgets/follows_tab_view.dart';

// Page Arguments
class FollowsPageArguments {
  final String username;
  final int initialIndex;

  FollowsPageArguments({@required this.username, this.initialIndex});
}

// Page
class FollowsPage extends StatefulWidget {
  final FollowsPageArguments args;

  FollowsPage({@required this.args});

  @override
  _FollowsPageState createState() => _FollowsPageState();
}

class _FollowsPageState extends State<FollowsPage> {
  final AccountsController _accountsController = locator<AccountsController>();
  List<AccountModel> _followersList;
  List<AccountModel> _followingList;
  bool _loading = true;

  // Functions
  @override
  initState() {
    super.initState();
    _initValues().then((_) => {_loading = false});
  }

  Future<void> _initValues() async {
    await _getFollowers();
    await _getFollowing();
  }

  Future<void> _getFollowers() async {
    var result = await _accountsController.getFollowers(widget.args.username);
    if (result.isRight()) {
      setState(() {
        _followersList = result.getOrElse(null);
      });
    }
  }

  Future<void> _getFollowing() async {
    var result = await _accountsController.getFollowing(widget.args.username);
    if (result.isRight()) {
      setState(() {
        _followingList = result.getOrElse(null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.args.initialIndex,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.args.username,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 17,
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                    icon: Text(
                  _followersList != null
                      ? "${_followersList.length}  Seguidores"
                      : 'Seguidores',
                  style: TextStyle(color: Colors.black),
                )),
                Tab(
                    icon: Text(
                  _followingList != null
                      ? "${_followingList.length}  Seguindo"
                      : 'Seguindo',
                  style: TextStyle(color: Colors.black),
                )),
              ],
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.blue),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return _loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : FollowsTabView(
                      constraints: constraints,
                      followersList: _followersList,
                      followingList: _followingList,
                      getFollowers: _getFollowers,
                      getFollowing: _getFollowing,
                    );
            },
          )),
    );
  }
}