import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final bool isEditMode;

  ProfilePicture({required this.isEditMode});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage('https://your-profile-picture-url'),
      child: isEditMode
          ? IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                // Handle image picking
              },
            )
          : null,
    );
  }
}
