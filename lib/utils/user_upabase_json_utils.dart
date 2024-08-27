import 'dart:convert';
import 'package:TableTies/data_models/user_supabase.dart';

class UserSupabaseJsonUtils {
  // Convert UserSupabase to JSON string
  static String userSupabaseToJson(UserSupabase user) {
    final userMap = user.toJson();
    return jsonEncode(userMap);
  }

  // Convert JSON string to UserSupabase
  static UserSupabase jsonToUserSupabase(String jsonString) {
    final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return UserSupabase.fromJson(userMap);
  }
}

// Usage example:
// void example() {
//   // Converting UserSupabase to JSON string
//   UserSupabase user = UserSupabase(/* ... */);
//   String jsonString = UserSupabaseJsonUtils.userSupabaseToJson(user);
//   print(jsonString);

//   // Converting JSON string back to UserSupabase
//   UserSupabase reconstructedUser =
//       UserSupabaseJsonUtils.jsonToUserSupabase(jsonString);
//   print(reconstructedUser);
// }
