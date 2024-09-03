import 'package:TableTies/blocs/profile/edit_profile_bloc.dart';
import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:TableTies/events/edit_profile_events.dart';
import 'package:TableTies/state/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../data_models/user_supabase.dart';
import '../../state/profile_states.dart';
import '../../events/profile_events.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile receivedUser;

  const EditProfileScreen({super.key, required this.receivedUser});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _occupationController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _occupationController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _occupationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileValidationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errors.values.join('\n'))),
            );
          } else if (state is EditProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          } else if (state is EditProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Profile updated successfully')),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              _buildSuccessState(widget.receivedUser),
              if (state is EditProfileLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSuccessState(UserProfile user) {
    _firstNameController.text = user.firstName ?? '';
    _lastNameController.text = user.lastName ?? '';
    _occupationController.text = user.occupation ?? '';
    _bioController.text = user.bio ?? '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProfilePicture(user),
          const SizedBox(height: 24),
          buildEditableField('First Name', _firstNameController),
          buildEditableField('Last Name', _lastNameController),
          buildEditableField('Occupation', _occupationController),
          buildEditableBio(),
          const SizedBox(height: 24),
          //    buildInterestsSection(user.interests ?? []),
          const SizedBox(height: 24),
          buildSaveButton(context),
        ],
      ),
    );
  }

  Widget buildProfilePicture(UserProfile user) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                user.profilePhoto != null && user.profilePhoto!.isNotEmpty
                    ? NetworkImage(user.profilePhoto!)
                    : const AssetImage('assets/images/profile_image.jpeg')
                        as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: IconButton(
                icon:
                    const Icon(Icons.camera_alt, size: 18, color: Colors.black),
                onPressed: () {
                  // TODO: Implement photo change functionality
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget buildEditableBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _bioController,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: 'Bio',
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget buildInterestsSection(List<String> interests) {
    // For simplicity, we're just displaying the interests here.
    // You might want to add functionality to edit interests later.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Interests',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: interests.map((interest) {
            return Chip(
              label: Text(
                interest,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              shape: const StadiumBorder(
                side: BorderSide(
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildSaveButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Create a map to hold only the changed fields
          Map<String, dynamic> updatedFields = {};

          // Check each field and add to updatedFields only if changed
          if (_firstNameController.text != widget.receivedUser.firstName &&
              _firstNameController.text.isNotEmpty) {
            updatedFields['firstName'] = _firstNameController.text;
          }
          if (_lastNameController.text != widget.receivedUser.lastName &&
              _lastNameController.text.isNotEmpty) {
            updatedFields['lastName'] = _lastNameController.text;
          }
          if (_occupationController.text != widget.receivedUser.occupation &&
              _occupationController.text.isNotEmpty) {
            updatedFields['occupation'] = _occupationController.text;
          }
          if (_bioController.text != widget.receivedUser.bio &&
              _bioController.text.isNotEmpty) {
            updatedFields['bio'] = _bioController.text;
          }

          // Dispatch update event to Edt Profile bloci
          if (updatedFields.isNotEmpty) {
            BlocProvider.of<EditProfileBloc>(context)
                .add(UpdateProfile(profileChanges: updatedFields));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'No changes detected. Please make changes before saving.'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text('Save Changes'),
      ),
    );
  }
}
