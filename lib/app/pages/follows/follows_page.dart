import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/accounts_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/stores/me_store.dart';

// Page Arguments
class FollowsPageArguments {
  final String uuid;
  final String username;

  FollowsPageArguments({@required this.uuid, @required this.username});
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
  final MeStore _meStore = locator<MeStore>();
  List<AccountModel> _followersList;
  List<AccountModel> _followingList;

  // Functions
  @override
  initState() {
    super.initState();
    _getFollowers();
    _getFollowing();
  }

  void _getFollowers() async {
    var result = await _accountsController.getFollowers(widget.args.uuid);
    if (result.isRight()) {
      setState(() {
        _followersList = result.getOrElse(null);
      });
    }
  }

  void _getFollowing() async {
    var result = await _accountsController.getFollowing(widget.args.uuid);
    if (result.isRight()) {
      setState(() {
        _followingList = result.getOrElse(null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.args.username,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 17,
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Text('follows page'),
        );
      }),
    );
  }
}
