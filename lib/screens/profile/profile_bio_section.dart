import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:flutter/material.dart';

class ProfileBioSection extends StatelessWidget {
  final _bioController = TextEditingController();

  final UserProfile user;
  final bool isEditing;

  ProfileBioSection({
    required this.user,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bio',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          child: isEditing
              ? TextField(
                  controller: _bioController,
                  maxLines: null, // Allow the TextField to expand as needed
                  decoration: InputDecoration(
                    border:
                        InputBorder.none, // Remove the default TextField border
                    hintText: 'Add a bio to make a great first impression!',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                )
              : Text(
                  user.bio ??
                      'Add a bio to make a great first impression! Edit your profile to get started.',
                  style: TextStyle(
                    fontSize: 16,
                    color: user.bio != null ? Colors.black : Colors.grey,
                  ),
                ),
        ),
      ],
    );
  }
}
