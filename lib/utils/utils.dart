import 'package:TableTies/services/preferences_service.dart';

void saveUserSession(String sessionToken) async {
  PreferencesService.preferences.setString('session_token', sessionToken);
}

void saveUserObject(String userSupabase) async {
  PreferencesService.preferences.setString('user', userSupabase);
}
