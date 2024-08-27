import 'package:TableTies/data_models/interests_model.dart';
import 'package:TableTies/data_models/user_supabase.dart';

class UserProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? occupation;
  final String? bio;
  final String? phone;
  final String? gender;
  final DateTime? birthday; // Using DateTime for better date handling
  final DateTime createdAt;
  final String? profilePhoto;
  List<Interest> interests;
  List<String> events;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.occupation,
    this.bio,
    this.phone,
    this.gender,
    this.birthday,
    required this.createdAt,
    this.profilePhoto,
    this.interests = const [], // Initialize with an empty list.
    this.events = const [], // Initialize with an empty list.
  });

  UserProfile copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? occupation,
    String? bio,
    String? phone,
    String? gender,
    DateTime? birthday,
    DateTime? createdAt,
    String? profilePhoto,
    List<Interest>? interests,
    List<String>? events,
  }) {
    return UserProfile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      occupation: occupation ?? this.occupation,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      createdAt: createdAt ?? this.createdAt,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      interests: interests ?? this.interests,
      events: events ?? this.events,
    );
  }

  factory UserProfile.fromUserSupabase(UserSupabase user) {
    return UserProfile(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      occupation: user.occupation,
      bio: user.bio,
      phone: user.phone,
      gender: user.gender,
      // Parse birthday string if available
      birthday:
          user.birthday != null ? DateTime.tryParse(user.birthday!) : null,
      createdAt: DateTime.parse(user.createdAt), // Parse createdAt string
      profilePhoto: user.profilePhoto,
      interests: [], // Initialize interests as an empty list
      events: [], // Initialize events as an empty list
    );
  }
}
