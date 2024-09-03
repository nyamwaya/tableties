import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final bool isEditMode;

  const ProfilePicture({super.key, required this.isEditMode});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: const NetworkImage('https://your-profile-picture-url'),
      child: isEditMode
          ? IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () {
                // Handle image picking
              },
            )
          : null,
    );
  }
}
