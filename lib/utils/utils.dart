import 'package:TableTies/services/preferences_service.dart';

void saveUserSession(String sessionToken) async {
  PreferencesService.preferences.setString('user_id', sessionToken);
}

//get user id
Future<String?> getUserId() async {
  final userId = PreferencesService.preferences.getString('user_id');
  return userId;
}

// Save user object
void saveUserObject(String userSupabase) async {
  PreferencesService.preferences.setString('cached_user', userSupabase);
}

// get user object
Future<String?> getUserObject() async {
  final cachedUserJson =
      PreferencesService.preferences.getString('cached_user');
  return cachedUserJson;
}
