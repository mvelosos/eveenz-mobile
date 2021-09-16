import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/accounts_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/account_follow_model.dart';
import 'package:party_mobile/app/pages/follows/widgets/follows_tab_view.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/view_models/search_vm.dart';

// Page Arguments
class FollowsPageArguments {
  final String username;
  final int? initialIndex;
  final int followersCount;
  final int followingCount;

  FollowsPageArguments({
    this.initialIndex,
    required this.username,
    required this.followersCount,
    required this.followingCount,
  });
}

// Page
class FollowsPage extends StatefulWidget {
  final FollowsPageArguments args;

  FollowsPage({required this.args});

  @override
  _FollowsPageState createState() => _FollowsPageState();
}

class _FollowsPageState extends State<FollowsPage> {
  final AccountsController _accountsController = locator<AccountsController>();
  List<AccountFollowModel>? _followersList;
  List<AccountFollowModel>? _followingList;
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

  Future<void> _getFollowers([SearchVM? search]) async {
    var result =
        await _accountsController.getFollowers(widget.args.username, search);
    if (result.isRight()) {
      setState(() {
        _followersList = result.getOrElse(() => {} as List<AccountFollowModel>);
      });
    }
  }

  Future<void> _getFollowing([SearchVM? search]) async {
    var result =
        await _accountsController.getFollowing(widget.args.username, search);
    if (result.isRight()) {
      setState(() {
        _followingList = result.getOrElse(() => {} as List<AccountFollowModel>);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.args.initialIndex ?? 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.args.username,
            style: TextStyle(
              color: AppColors.darkPurple,
              fontSize: 17,
            ),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.darkPurple,
            onTap: (idx) {
              FocusScope.of(context).unfocus();
            },
            tabs: [
              Tab(
                icon: Text(
                  "${widget.args.followersCount}  Seguidores",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Text(
                  "${widget.args.followingCount}  Seguindo",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: AppColors.orange),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : FollowsTabView(
                    constraints: constraints,
                    followersList: _followersList ?? [],
                    followingList: _followingList ?? [],
                    getFollowers: _getFollowers,
                    getFollowing: _getFollowing,
                  );
          },
        ),
      ),
    );
  }
}
