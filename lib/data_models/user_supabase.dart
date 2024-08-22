import 'dart:convert';

class UserSupabase {
  final String id;
  final String firstName;
  final String email;
  final String? occupation;
  final String? bio;
  final String? phone;
  final String? gender;
  final String? birthday;
  final String createdAt;
  final String lastName;

  UserSupabase({
    required this.id,
    required this.firstName,
    required this.email,
    this.occupation,
    this.bio,
    this.phone,
    this.gender,
    this.birthday,
    required this.createdAt,
    required this.lastName,
  });

  // Convert JSON to User object
  factory UserSupabase.fromJson(Map<String, dynamic> json) {
    return UserSupabase(
      id: json['id'],
      firstName: json['first_name'],
      email: json['email'],
      occupation: json['occupation'],
      bio: json['bio'],
      phone: json['phone'],
      gender: json['gender'],
      birthday: json['birthday'],
      createdAt: json['created_at'],
      lastName: json['last_name'],
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'email': email,
      'occupation': occupation,
      'bio': bio,
      'phone': phone,
      'gender': gender,
      'birthday': birthday,
      'created_at': createdAt,
      'last_name': lastName,
    };
  }

  // Convert JSON string to List of User objects
  static List<UserSupabase> fromJsonList(String jsonString) {
    final data = jsonDecode(jsonString) as List;
    return data.map((json) => UserSupabase.fromJson(json)).toList();
  }
}
