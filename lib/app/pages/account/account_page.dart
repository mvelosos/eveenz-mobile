import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/users_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/user_model.dart';

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
  final UsersController _usersController = locator<UsersController>();
  UserModel _userModel;
  bool _loading = true;

  // Functions

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    var result = await _usersController.getUser(widget.args.username);
    if (result.isRight()) {
      setState(() {
        _userModel = result.getOrElse(null);
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? '' : _userModel.user.username,
            style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Text(_userModel.user.username),
                );
        },
      ),
    );
  }
}
