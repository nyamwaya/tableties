// profile_header.dart
import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:TableTies/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile user;
  final bool isEditing;
  final VoidCallback onEditToggle;

  ProfileHeader({
    required this.user,
    required this.isEditing,
    required this.onEditToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Conditionally render the back arrow button
            if (!isEditing)
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            // Conditionally render the settings button
            if (!isEditing)
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  // Handle settings button press
                },
              ),
          ],
        ),
        SizedBox(height: 16),
        CircleAvatar(
            // ... (rest of the CircleAvatar code remains the same)
            ),
        SizedBox(height: 16),

        // Conditionally render the name as text or text fields
        if (isEditing)
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: user.firstName),
                  decoration:
                      InputDecoration(hintText: 'Enter your first name'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: user.lastName),
                  decoration: InputDecoration(hintText: 'Enter your last name'),
                ),
              ),
            ],
          )
        else
          Text(
            '${user.firstName} ${user.lastName}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

        // Conditionally render the occupation as text or a text field
        if (isEditing)
          TextField(
            controller: TextEditingController(text: user.occupation),
            decoration: InputDecoration(hintText: 'Enter your occupation'),
          )
        else
          Text(
            '${user.occupation ?? 'Enter your occupation'}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

        SizedBox(height: 16),

        // Change the button text based on the edit state
        ElevatedButton(
          child: Text(isEditing ? 'Save Changes' : 'Edit Profile'),
          onPressed: () {
            // Toggle the edit state
            onEditToggle();

            // If saving changes, you'd typically update the user profile here
            if (!isEditing) {
              // ... (logic to save the changes to the profile)
            }
          },
          // ... (rest of the ElevatedButton code remains the same)
        ),
      ],
    );
  }
}
