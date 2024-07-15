import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static late final PreferencesService _instance;
  static late SharedPreferences _preferences;

  PreferencesService._internal();

  factory PreferencesService() {
    return _instance;
  }

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _instance = PreferencesService._internal();
  }

  static SharedPreferences get preferences => _preferences;
}
