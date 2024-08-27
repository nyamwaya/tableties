import 'dart:convert';

import 'package:TableTies/data_models/interests_model.dart';
import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:TableTies/data_models/user_supabase.dart';
import 'package:TableTies/screens/home/home_screen.dart';
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
  bool isEditing = false;

  void toggleEditState() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    // before
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

// new approah i am concidering.
    // @override
    // void initState() {
    //   super.initState();
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     final profileBloc = BlocProvider.of<ProfileBloc>(context);
    //     final currentState = profileBloc.state;

    //     if (currentState is ProfileInitial) {
    //       // Load data only if it's the initial state (no data loaded yet)
    //       profileBloc.add(LoadUserProfile());
    //     }
    //     // else {
    //     //   // You might want to handle other scenarios here, like refreshing data after an update
    //     // }
    //   });
    // }

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            // Your UI based on the ProfileState
            if (state is ProfileInitial) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                profileBloc.add(LoadUserProfile());
              });

              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoading) {
              // everytime we are coming to this screen we are loading the data and making api calls.
              // we need to come up with a candance where we at least retreive the last UserModel saved in shared prefs
              // or at least whatever object we have in the state. because the only things that are truly changing is when a user
              // updates thier profile information.
              // or when a user is logged out and we have to log them back in.
              // and also when a user signs up for an event.  this is rediculous but for now we can do.
              return Text('Profile Loading: ${state.props.first}');
            } else if (state is ProfileLoaded) {
              // final userData = state.props.first as String;
              // final user = UserSupabase.fromJson(jsonDecode(userData));

              final user = state.userProfile;

              // return Text('User name: ${user.firstName} ${user.lastName}');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(user, context, isEditing, toggleEditState),
                  SizedBox(height: 24),
                  buildBioSection(user, isEditing),
                  SizedBox(height: 24),
                  buildInterestsSection(user.interests)
                ],
              );
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

Widget buildHeader(UserProfile user, BuildContext context, bool isEditing,
    VoidCallback toggleEditState) {
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
                decoration: InputDecoration(hintText: 'Enter your first name'),
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
          toggleEditState();

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

Widget buildBioSection(UserProfile user, bool isEditing) {
  TextEditingController _bioController = TextEditingController(text: user.bio);

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

Widget buildInterestsSection(List<Interest> interests) {
  // Define the colors extracted from the image
  final List<Color> chipColors = [
    Color(0xFFFFFFFF), // White for Travel
    Color(0xFFFFF4D6), // Light yellow for Big Foodie
    Color(0xFFD6F5FF), // Light blue for Photography
    Color(0xFFFFE6FF), // Light pink for Bollywood Movie
    Color(0xFFE6E6FF), // Light purple for Sharukh Khan
  ];

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
        children: interests.asMap().entries.map((entry) {
          int index = entry.key;
          Interest interest = entry.value;
          return Chip(
            label: Text(
              interest.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            backgroundColor: chipColors[index % chipColors.length],
            shape: StadiumBorder(
              side: BorderSide(
                color: Colors.black,
                width: 1.5, // Slightly thicker border
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          );
        }).toList(),
      ),
    ],
  );
}
