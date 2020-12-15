// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthUserStore on _AuthUserStoreBase, Store {
  final _$tokenAtom = Atom(name: '_AuthUserStoreBase.token');

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  final _$tokenTypeAtom = Atom(name: '_AuthUserStoreBase.tokenType');

  @override
  String get tokenType {
    _$tokenTypeAtom.reportRead();
    return super.tokenType;
  }

  @override
  set tokenType(String value) {
    _$tokenTypeAtom.reportWrite(value, super.tokenType, () {
      super.tokenType = value;
    });
  }

  final _$expAtom = Atom(name: '_AuthUserStoreBase.exp');

  @override
  String get exp {
    _$expAtom.reportRead();
    return super.exp;
  }

  @override
  set exp(String value) {
    _$expAtom.reportWrite(value, super.exp, () {
      super.exp = value;
    });
  }

  final _$providerAtom = Atom(name: '_AuthUserStoreBase.provider');

  @override
  String get provider {
    _$providerAtom.reportRead();
    return super.provider;
  }

  @override
  set provider(String value) {
    _$providerAtom.reportWrite(value, super.provider, () {
      super.provider = value;
    });
  }

  final _$_AuthUserStoreBaseActionController =
      ActionController(name: '_AuthUserStoreBase');

  @override
  void setUser(AuthUserModel authUser) {
    final _$actionInfo = _$_AuthUserStoreBaseActionController.startAction(
        name: '_AuthUserStoreBase.setUser');
    try {
      return super.setUser(authUser);
    } finally {
      _$_AuthUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clean() {
    final _$actionInfo = _$_AuthUserStoreBaseActionController.startAction(
        name: '_AuthUserStoreBase.clean');
    try {
      return super.clean();
    } finally {
      _$_AuthUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
token: ${token},
tokenType: ${tokenType},
exp: ${exp},
provider: ${provider}
    ''';
  }
}
