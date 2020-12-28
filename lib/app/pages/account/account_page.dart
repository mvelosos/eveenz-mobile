import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/accounts_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/account_model.dart';
import 'package:party_mobile/app/pages/account/widgets/follow_button.dart';
import 'package:party_mobile/app/stores/me_store.dart';

// Page Arguments
class AccountPageArguments {
  final String username;

  AccountPageArguments({@required this.username});
}

// Page
class AccountPage extends StatefulWidget {
  final AccountPageArguments args;

  AccountPage({@required this.args});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AccountsController _accountsController = locator<AccountsController>();
  final MeStore _meStore = locator<MeStore>();
  AccountModel _accountModel;
  bool _loading = true;
  bool _showFollowButton = false;

  // Functions

  @override
  void initState() {
    super.initState();
    _getAccount();
  }

  Future<void> _getAccount() async {
    var result = await _accountsController.getAccount(widget.args.username);
    if (result.isRight()) {
      setState(() {
        _accountModel = result.getOrElse(null);
        _shouldShowFollowButton();
        _loading = false;
      });
    }
  }

  void _shouldShowFollowButton() {
    if (_accountModel.account.uuid != _meStore.uuid) {
      _showFollowButton = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _loading ? '' : _accountModel.account.username,
          style: TextStyle(color: Colors.blue),
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
              : RefreshIndicator(
                  color: Colors.blue,
                  displacement: 0,
                  onRefresh: () async {
                    await _getAccount();
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    _accountModel.account.events.toString(),
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  Text('Festas'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    _accountModel.account.followers.toString(),
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  Text('Seguidores'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    _accountModel.account.following.toString(),
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  Text('Seguindo'),
                                ],
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: _accountModel.account.avatarUrl != ''
                                    ? Image.network(
                                        _accountModel.account.avatarUrl,
                                        height: 85,
                                        width: 85,
                                      )
                                    : CircleAvatar(
                                        radius: 45,
                                        backgroundColor: Color(0xffd3d5db),
                                      ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _showFollowButton
                                  ? FollowButton(
                                      constraints, _accountModel, _getAccount)
                                  : SizedBox.shrink(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
