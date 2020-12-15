import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:party_mobile/app/models/auth_user_model.dart';
part 'auth_user_store.g.dart';

class AuthUserStore = _AuthUserStoreBase with _$AuthUserStore;

abstract class _AuthUserStoreBase with Store {
  @observable
  String token = '';

  @observable
  String tokenType = '';

  @observable
  String exp = '';

  @observable
  String provider = '';

  @action
  void setUser(AuthUserModel authUser) {
    token = authUser.token;
    tokenType = authUser.tokenType;
    exp = authUser.exp;
    provider = authUser.provider;
  }

  @action
  void clean() {
    token = '';
    tokenType = '';
    exp = '';
    provider = '';
  }
}
