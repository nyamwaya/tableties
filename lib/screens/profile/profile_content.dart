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

  ProfileContent({
    required this.userProfile,
    required this.isEditing,
    required this.onEditToggle,
  });

  @override
  Widget build(BuildContext context) {
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
          isEditing: isEditing,
          userInterests: userProfile.interests,
          selectedInterests: [
            'Travel',
            'Big Foodie',
            'Photography',
            'Bollywood Movie',
            'Sharukh Khan'
          ],
          showLimitError: false,
          updateInterests: (interests, showError) {},
        ),
      ],
    );
  }
}
