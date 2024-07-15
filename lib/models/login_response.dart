import 'package:TableTies/models/user.dart';

class LoginResponse {
  String requestId;
  dynamic session;
  String sessionJwt;
  String sessionToken;
  int statusCode;
  User user;
  String userId;

  LoginResponse({
    required this.requestId,
    required this.session,
    required this.sessionJwt,
    required this.sessionToken,
    required this.statusCode,
    required this.user,
    required this.userId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      requestId: json['request_id'],
      session: json['session'],
      sessionJwt: json['session_jwt'],
      sessionToken: json['session_token'],
      statusCode: json['status_code'],
      user: User.fromJson(json['user']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'session': session,
      'session_jwt': sessionJwt,
      'session_token': sessionToken,
      'status_code': statusCode,
      'user': user.toJson(),
      'user_id': userId,
    };
  }
}
