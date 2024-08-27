import 'dart:convert';

import 'package:TableTies/data_models/user_supabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/profile/profile_picture_widget.dart';
import '../../widgets/profile/profile_info_widget.dart';
import '../../widgets/profile/interests_chips_widget.dart';
import '../../blocs/profile/profile_bloc.dart';
import 'package:TableTies/state/profile_states.dart';
import 'package:TableTies/events/profile_events.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileBloc.add(DisplayUserFromMemory());
    });

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            // Your UI based on the ProfileState
            if (state is ProfileInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoading) {
              return Text('Profile Loading: ${state.props.first}');
            } else if (state is ProfileLoaded) {
              // this should be an example of how we get valid json to and from the response.
              final userData = jsonDecode(state.props.first as String);
              final user = UserSupabase.fromJson(userData);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(user),
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

Widget buildHeader(UserSupabase user) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button press
            },
          ),
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
        radius: 50,
        backgroundImage: AssetImage(
            'assets/profile_image.png'), // Replace with actual image path
      ),
      SizedBox(height: 16),
      Text(
        '${user.firstName} ${user.lastName}',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        '${user.occupation ?? 'Enter your occupation'}',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
      SizedBox(height: 16),
      ElevatedButton(
        child: Text('Edit Profile'),
        onPressed: () {
          // Handle edit profile button press
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ],
  );
}
