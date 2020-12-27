// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeStore on _MeStoreBase, Store {
  final _$uuidAtom = Atom(name: '_MeStoreBase.uuid');

  @override
  String get uuid {
    _$uuidAtom.reportRead();
    return super.uuid;
  }

  @override
  set uuid(String value) {
    _$uuidAtom.reportWrite(value, super.uuid, () {
      super.uuid = value;
    });
  }

  final _$usernameAtom = Atom(name: '_MeStoreBase.username');

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$nameAtom = Atom(name: '_MeStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$bioAtom = Atom(name: '_MeStoreBase.bio');

  @override
  String get bio {
    _$bioAtom.reportRead();
    return super.bio;
  }

  @override
  set bio(String value) {
    _$bioAtom.reportWrite(value, super.bio, () {
      super.bio = value;
    });
  }

  final _$popularityAtom = Atom(name: '_MeStoreBase.popularity');

  @override
  int get popularity {
    _$popularityAtom.reportRead();
    return super.popularity;
  }

  @override
  set popularity(int value) {
    _$popularityAtom.reportWrite(value, super.popularity, () {
      super.popularity = value;
    });
  }

  final _$eventsAtom = Atom(name: '_MeStoreBase.events');

  @override
  int get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(int value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  final _$followingAtom = Atom(name: '_MeStoreBase.following');

  @override
  int get following {
    _$followingAtom.reportRead();
    return super.following;
  }

  @override
  set following(int value) {
    _$followingAtom.reportWrite(value, super.following, () {
      super.following = value;
    });
  }

  final _$followersAtom = Atom(name: '_MeStoreBase.followers');

  @override
  int get followers {
    _$followersAtom.reportRead();
    return super.followers;
  }

  @override
  set followers(int value) {
    _$followersAtom.reportWrite(value, super.followers, () {
      super.followers = value;
    });
  }

  final _$avatarUrlAtom = Atom(name: '_MeStoreBase.avatarUrl');

  @override
  String get avatarUrl {
    _$avatarUrlAtom.reportRead();
    return super.avatarUrl;
  }

  @override
  set avatarUrl(String value) {
    _$avatarUrlAtom.reportWrite(value, super.avatarUrl, () {
      super.avatarUrl = value;
    });
  }

  final _$_MeStoreBaseActionController = ActionController(name: '_MeStoreBase');

  @override
  void setMe(ProfileModel profileModel) {
    final _$actionInfo =
        _$_MeStoreBaseActionController.startAction(name: '_MeStoreBase.setMe');
    try {
      return super.setMe(profileModel);
    } finally {
      _$_MeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
uuid: ${uuid},
username: ${username},
name: ${name},
bio: ${bio},
popularity: ${popularity},
events: ${events},
following: ${following},
followers: ${followers},
avatarUrl: ${avatarUrl}
    ''';
  }
}
