import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;

  late SharedPreferences _prefs;

  SharedPreferencesService._internal() {
    init();
  }

  static SharedPreferencesService get instance {
    if (_instance == null) {
      _instance = SharedPreferencesService._internal();
    }

    return _instance!;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }
}
