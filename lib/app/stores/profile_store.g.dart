// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStoreBase, Store {
  final _$usernameAtom = Atom(name: '_ProfileStoreBase.username');

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

  final _$nameAtom = Atom(name: '_ProfileStoreBase.name');

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

  final _$bioAtom = Atom(name: '_ProfileStoreBase.bio');

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

  final _$popularityAtom = Atom(name: '_ProfileStoreBase.popularity');

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

  final _$eventsAtom = Atom(name: '_ProfileStoreBase.events');

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

  final _$followingAtom = Atom(name: '_ProfileStoreBase.following');

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

  final _$followersAtom = Atom(name: '_ProfileStoreBase.followers');

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

  final _$avatarUrlAtom = Atom(name: '_ProfileStoreBase.avatarUrl');

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

  final _$_ProfileStoreBaseActionController =
      ActionController(name: '_ProfileStoreBase');

  @override
  void setProfile(ProfileModel profileModel) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setProfile');
    try {
      return super.setProfile(profileModel);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
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
