import 'dart:convert';

import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:TableTies/data_models/user_supabase.dart';
import 'package:TableTies/screens/home/home_screen.dart';
import 'package:TableTies/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/profile/profile_picture_widget.dart';
import '../../widgets/profile/profile_info_widget.dart';
import '../../widgets/profile/interests_chips_widget.dart';
import '../../blocs/profile/profile_bloc.dart';
import 'package:TableTies/state/profile_states.dart';
import 'package:TableTies/events/profile_events.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileBloc.add(const DisplayUserFromMemory());
    });

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            // Your UI based on the ProfileState
            if (state is ProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoading) {
              return Text('Profile Loading: ${state.props.first}');
            } else if (state is ProfileLoaded) {
              final user = state.props.first as UserProfile;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(user, context),
                  const SizedBox(height: 24),
                  buildBioSection(user),
                  const SizedBox(height: 24),
                  buildInterestsSection(user)
                ],
              );

              // return Text('User name: ${user.firstName} ${user.lastName}');
            } else if (state is ProfileError) {
              return Text('Profile Error: ${state.props.first}');
            } else {
              return Container(); // Or your default UI
            }
          },
        ),
      ),
    )));
  }
}

Widget buildHeader(UserProfile user, BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button press
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      const SizedBox(height: 16),
      CircleAvatar(
        radius: 50,
        backgroundImage: user.profilePhoto != null &&
                user.profilePhoto?.isNotEmpty == true
            ? NetworkImage(user.profilePhoto!)
            : const AssetImage(
                'assets/images/profile_image.jpeg'), // Replace with actual image path
      ),
      const SizedBox(height: 16),
      Text(
        '${user.firstName} ${user.lastName}',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        user.occupation ?? 'Enter your occupation',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          // Handle edit profile button press
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditProfileScreen(receivedUser: user)),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text('Edit Profile'),
      ),
    ],
  );
}

Widget buildBioSection(UserProfile user) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Bio',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
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

Widget buildInterestsSection(UserProfile user) {
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
      user.interests.isEmpty
          ? const Text(
              'No interests yet. Edit your profile to add interests.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            )
          : Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: user.interests.map((interest) {
                return Chip(
                  label: Text(
                    interest.name,
                    style: const TextStyle(
                      fontSize: 16,
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
