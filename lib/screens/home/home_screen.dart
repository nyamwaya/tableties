import 'package:TableTies/widgets/header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:TableTies/blocs/home/home_bloc.dart';
import 'package:TableTies/events/home_event.dart';
import 'package:TableTies/state/home_state.dart';
import 'package:TableTies/widgets/complete_profile_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    final userId = ModalRoute.of(context)?.settings.arguments as String?;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeBloc.add(FetchUserById(userId: userId));
    });

    return BlocConsumer<HomeBloc, HomeState>(
      // Use BlocConsumer here
      listener: (context, state) {
        if (state is HomeSuccess) {
          print('Home Success: ${state.resource.data}');
          // HomeSuccess state indicates that the user data has been successfully fetched from the users table
          // Trigger profile check after fetching user data
          homeBloc.add(const CheckProfileCompletion());
        } else if (state is HomeFailure) {
          // HomeFailure state indicates that there was an error while fetching the user data from the users table
          // This could happen due to network issues, database errors, or if the user doesn't exist
          // Here we're logging the error, but we might want to show a user-friendly error message or take other actions
          print('Home Failure: ${state.resource.error}');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const AppHeader(),
            automaticallyImplyLeading: false,
          ),
          body: _buildContent(context, state, homeBloc),
        );
      },
    );
  }
}

Widget _buildContent(BuildContext context, HomeState state, HomeBloc homeBloc) {
  if (state is HomeInitial || state is HomeSuccess) {
    // Show loading indicator while fetching user or checking profile
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  } else if (state is HomeProfileComplete) {
    // Directly return the list page widget (assuming you have a ListPage widget)
    return const Center(child: Text('List Page'));
  } else if (state is HomeProfileIncomplete) {
    // Directly return the complete profile widget (assuming you have a CompleteProfilePage widget)
    return CompleteProfileWidget(missingInterests: state.resource.data);
  } else if (state is HomeFailure) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.resource.error}'),
            ElevatedButton(
              onPressed: () => homeBloc.add(const CheckProfileCompletion()),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  } else {
    return const Scaffold(body: Center(child: Text('Unknown state')));
  }
}
