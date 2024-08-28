import 'dart:convert';

import 'package:TableTies/data_models/interests_model.dart';
import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:TableTies/data_models/user_supabase.dart';
import 'package:TableTies/screens/home/home_screen.dart';
import 'package:TableTies/screens/profile/profile_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/profile/profile_picture_widget.dart';
import '../../widgets/profile/profile_info_widget.dart';
import '../../widgets/profile/interests_chips_widget.dart';
import '../../blocs/profile/profile_bloc.dart';
import 'package:TableTies/state/profile_states.dart';
import 'package:TableTies/events/profile_events.dart';

import 'dart:convert';

import 'package:TableTies/data_models/interests_model.dart';
import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:TableTies/data_models/user_supabase.dart';
import 'package:TableTies/screens/home/home_screen.dart';
import 'package:TableTies/screens/profile/profile_content.dart';
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
  List<String> selectedInterests = [];
  bool showLimitError = false;

  void toggleEditState() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void onInterestsUpdated(List<String> interests) {
    // Handle updated interests here, e.g., update state or send to backend
    print('Updated interests: $interests');
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileInitial) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    profileBloc.add(LoadUserProfile());
                  });
                  return Container();
                } else if (state is ProfileLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProfileLoaded) {
                  final userProfile = state.userProfile;
                  return ProfileContent(
                    userProfile: userProfile,
                    isEditing: isEditing,
                    onEditToggle: toggleEditState,
                    onInterestsUpdated: onInterestsUpdated,
                    selectedInterests: selectedInterests,
                    showLimitError: showLimitError,
                  );
                } else if (state is ProfileError) {
                  return Text('Profile Error: ${state.props.first}');
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
