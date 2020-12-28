import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/me_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/account_model.dart';

class FollowButton extends StatefulWidget {
  final BoxConstraints _constraints;
  final AccountModel _accountModel;
  final Function _getAccount;

  FollowButton(this._constraints, this._accountModel, this._getAccount);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  MeController _meController = locator<MeController>();
  bool _loading = false;

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  void followAccount() async {
    _setLoading(true);
    await _meController.followAccount(widget._accountModel.account.uuid);
    await widget._getAccount();
    _setLoading(false);
  }

  void unfollowAccount() async {
    _setLoading(true);
    await _meController.unfollowAccount(widget._accountModel.account.uuid);
    await widget._getAccount();
    _setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: widget._constraints.maxHeight * .025,
      ),
      child: widget._accountModel.account.followedByMe
          ? RaisedButton(
              onPressed: _loading ? null : unfollowAccount,
              disabledColor: Colors.grey[350],
              child: _loading
                  ? SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      height: 13,
                      width: 13,
                    )
                  : Text(
                      'Parar de seguir',
                      style: TextStyle(color: Colors.white),
                    ),
              color: Colors.redAccent,
            )
          : RaisedButton(
              onPressed: _loading ? null : followAccount,
              disabledColor: Colors.grey[350],
              child: _loading
                  ? SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      height: 13,
                      width: 13,
                    )
                  : Text(
                      'Seguir',
                      style: TextStyle(color: Colors.white),
                    ),
              color: Colors.blue,
            ),
    );
  }
}
