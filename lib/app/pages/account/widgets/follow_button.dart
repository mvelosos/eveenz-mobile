import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
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
  ProfileController _profileController = locator<ProfileController>();
  bool _loading = false;

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  void followAccount() async {
    _setLoading(true);
    await _profileController.followAccount(widget._accountModel.uuid);
    await widget._getAccount();
    _setLoading(false);
  }

  void unfollowAccount() async {
    _setLoading(true);
    await _profileController.unfollowAccount(widget._accountModel.uuid);
    await widget._getAccount();
    _setLoading(false);
  }

  void deleteFollowRequest() async {
    _setLoading(true);
    await _profileController.deleteRequestFollows(
        widget._accountModel.requestedByMe?['requestFollowUuid']);
    await widget._getAccount();
    _setLoading(false);
  }

  Widget _followButtons() {
    if (widget._accountModel.requestedByMe?['isRequestedByMe'] == true) {
      return ElevatedButton(
        onPressed: _loading ? null : deleteFollowRequest,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
        ),
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
                'Cancelar solicitação',
                style: TextStyle(color: Colors.white),
              ),
      );
    }

    return widget._accountModel.followedByMe
        ? ElevatedButton(
            onPressed: _loading ? null : unfollowAccount,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.redAccent),
            ),
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
          )
        : ElevatedButton(
            onPressed: _loading ? null : followAccount,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            // disabledColor: Colors.grey[350],
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
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          top: widget._constraints.maxHeight * .025,
        ),
        child: _followButtons());
  }
}
