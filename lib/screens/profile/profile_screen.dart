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
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
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
            return Text('User name: ${user.firstName} ${user.lastName}');
          } else if (state is ProfileError) {
            return Text('Profile Error: ${state.props.first}');
          } else {
            return Container(); // Or your default UI
          }
        },
      ),
    );
  }
}

// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProfileBloc(),
//       child: ProfileView(),
//     );
//   }
// }

// class ProfileView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileBloc, ProfileState>(
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Profile'),
//             actions: [
//               IconButton(
//                 icon: Icon(state.isEditMode ? Icons.save : Icons.edit),
//                 onPressed: () => context.read<ProfileBloc>().add(
//                   state.isEditMode ? SaveProfile() : ToggleEditMode()
//                 ),
//               ),
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 ProfilePicture(isEditMode: state.isEditMode),
//                 ProfileField(
//                   label: 'Name',
//                   value: state.name,
//                   isEditMode: state.isEditMode,
//                   onChanged: (value) => context.read<ProfileBloc>().add(UpdateName(value)),
//                 ),
//                 ProfileField(
//                   label: 'Occupation',
//                   value: state.occupation,
//                   isEditMode: state.isEditMode,
//                   onChanged: (value) => context.read<ProfileBloc>().add(UpdateOccupation(value)),
//                 ),
//                 ProfileField(
//                   label: 'Bio',
//                   value: state.bio,
//                   isEditMode: state.isEditMode,
//                   onChanged: (value) => context.read<ProfileBloc>().add(UpdateBio(value)),
//                 ),
//                 InterestsChips(
//                   interests: state.interests,
//                   isEditMode: state.isEditMode,
//                   onInterestChanged: (newInterests) => context.read<ProfileBloc>().add(UpdateInterests(newInterests)),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
