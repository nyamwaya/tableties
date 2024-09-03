import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../data_models/user_supabase.dart';
import '../../state/profile_states.dart';
import '../../events/profile_events.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

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
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            final user = UserSupabase.fromJson(
                state.props.first as Map<String, dynamic>);
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
                  SizedBox(height: 24),
                  buildEditableField('First Name', _firstNameController),
                  buildEditableField('Last Name', _lastNameController),
                  buildEditableField('Occupation', _occupationController),
                  buildEditableBio(),
                  SizedBox(height: 24),
                  //    buildInterestsSection(user.interests ?? []),
                  SizedBox(height: 24),
                  //  buildSaveButton(context, user),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildProfilePicture(UserSupabase user) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                user.profilePhoto != null && user.profilePhoto!.isNotEmpty
                    ? NetworkImage(user.profilePhoto!)
                    : AssetImage('assets/images/profile_image.jpeg')
                        as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: IconButton(
                icon: Icon(Icons.camera_alt, size: 18, color: Colors.black),
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
        Text(
          'Interests',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: interests.map((interest) {
            return Chip(
              label: Text(
                interest,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              shape: StadiumBorder(
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

  // Widget buildSaveButton(BuildContext context, UserSupabase user) {
  //   return Center(
  //     child: ElevatedButton(
  //       child: Text('Save Changes'),
  //       onPressed: () {
  //         // Update user object with new values
  //         user.firstName = _firstNameController.text;
  //         user.lastName = _lastNameController.text;
  //         user.occupation = _occupationController.text;
  //         user.bio = _bioController.text;

  //         // Dispatch update event to ProfileBloc
  //         BlocProvider.of<ProfileBloc>(context).add(UpdateUserProfile(user));

  //         // Navigate back to profile screen
  //         Navigator.pop(context);
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: Colors.black,
  //         foregroundColor: Colors.white,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
