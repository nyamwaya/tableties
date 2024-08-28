// profile_content.dart
import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:TableTies/screens/profile/profile_bio_section.dart';
import 'package:TableTies/screens/profile/profile_header.dart';
import 'package:TableTies/screens/profile/profile_interests_section.dart';
import 'package:flutter/material.dart';

class ProfileContent extends StatelessWidget {
  final UserProfile userProfile;
  final bool isEditing;
  final VoidCallback onEditToggle;
  final Function(List<String>) onInterestsUpdated;
  final List<String> selectedInterests;
  final bool showLimitError;

  ProfileContent({
    required this.userProfile,
    required this.isEditing,
    required this.onEditToggle,
    required this.onInterestsUpdated,
    required this.selectedInterests,
    required this.showLimitError,
  });

  @override
  Widget build(BuildContext context) {
    List<AllInterests> allInterests = [
      AllInterests(name: 'Hiking', category: 'Sports'),
      AllInterests(name: 'Basketball', category: 'Sports'),
      AllInterests(name: 'Painting', category: 'Arts & Culture'),
      AllInterests(name: 'Playing Guitar', category: 'Arts & Culture'),
      AllInterests(name: 'Cooking Italian Food', category: 'Food & Drink'),
      AllInterests(name: 'Brewing Coffee', category: 'Food & Drink'),
      AllInterests(name: 'Backpacking', category: 'Travel & Adventure'),
      AllInterests(name: 'Scuba Diving', category: 'Travel & Adventure'),
      AllInterests(
          name: 'Playing Video Games', category: 'Gaming & Technology'),
      AllInterests(name: 'Learning to Code', category: 'Gaming & Technology'),
    ];
    return Column(
      children: [
        ProfileHeader(
          user: userProfile,
          isEditing: isEditing,
          onEditToggle: onEditToggle,
        ),
        SizedBox(height: 24),
        ProfileBioSection(
          user: userProfile,
          isEditing: isEditing,
        ),
        SizedBox(height: 24),
        ProfileInterestsSection(
          userInterests: userProfile.interests,
          isEditing: isEditing,
          onInterestsUpdated: onInterestsUpdated,
          allInterests: allInterests,
        ),
      ],
    );
  }
}

class AllInterests {
  String name;
  String category;

  AllInterests({required this.name, required this.category});
}
