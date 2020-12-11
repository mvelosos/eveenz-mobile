import 'package:party_mobile/app/interfaces/local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService implements ILocalStorage {
  @override
  Future get(String key) async {
    var _shared = await SharedPreferences.getInstance();
    return _shared.get(key);
  }

  @override
  Future put(String key, value) async {
    var _shared = await SharedPreferences.getInstance();
    if (value is bool) {
      _shared.setBool(key, value);
    } else if (value is String) {
      _shared.setString(key, value);
    } else if (value is int) {
      _shared.setInt(key, value);
    } else if (value is double) {
      _shared.setDouble(key, value);
    }
  }

  @override
  Future delete(String key) async {
    var _shared = await SharedPreferences.getInstance();
    _shared.remove(key);
  }

  @override
  Future clear() async {
    var _shared = await SharedPreferences.getInstance();
    _shared.clear();
  }
}
