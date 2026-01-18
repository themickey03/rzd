import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  late SharedPreferences _preferences;
  bool _isInit = false;

  StorageService() {
    SharedPreferences.getInstance().then((prefs) {
      _preferences = prefs;
      _isInit = true;
    });
  }

  operator [](String key) {
    if (!_isInit) {
      throw "StorageService not loaded";
    }
    return _preferences.get(key);
  }

  void operator []=(String key, dynamic value) {
    if (!_isInit) {
      throw "StorageService not loaded";
    }

    if (value == null) {
      _preferences.remove(key);
      return;
    }

    switch (value.runtimeType) {
      case const (int):
        _preferences.setInt(key, value);
        break;
      case const (String):
        _preferences.setString(key, value);
        break;
      case const (double):
        _preferences.setDouble(key, value);
        break;
      case const (List<String>):
        _preferences.setStringList(key, value);
        break;
      case const (bool):
        _preferences.setBool(key, value);
        break;
      default:
        _preferences.setString(key, value.toString());
        break;
    }
  }

  void clear() {
    if (!_isInit) {
      throw "StorageService not loaded";
    }
    _preferences.clear();
  }

  void reload() {
    if (!_isInit) {
      throw "StorageService not loaded";
    }
    _preferences.reload();
  }

  bool containsKey({required String key}) {
    if (!_isInit) {
      throw "StorageService not loaded";
    }
    return _preferences.containsKey(key);
  }

}