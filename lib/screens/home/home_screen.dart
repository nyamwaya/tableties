import 'dart:convert';
import 'package:TableTies/blocs/home/home_bloc.dart';
import 'package:TableTies/events/home_event.dart';
import 'package:TableTies/state/home_state.dart';
import 'package:flutter/material.dart';
import 'package:TableTies/data_models/user_supabase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as UserSupabase?;

    // Trigger an event in the HomeBloc based on the args (if needed)

    if (user != null) {
      // this will occure when a user is signing up or has just returned to the app after closing it or resuming or pulling to refresh.
      context.read<HomeBloc>().add(CacheUser(user));
    } else {
      //this might occure when a user logged out and all we have is their uuid
      context.read<HomeBloc>().add(FetchUserById());
    }

    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocProvider(
      create: (context) => homeBloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            // Initial state, perhaps show a loading indicator
            return Scaffold(
              appBar: AppBar(
                title: Text('Home'),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is HomeSuccess) {
            final user = state.resource.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
              ),
              body: Center(
                child: Text('Welcome, ${user?.firstName ?? ''}!'),
              ),
            );
          } else if (state is HomeFailure) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
              ),
              body: Center(
                child: Text('Error: ${state.resource.error}'),
              ),
            );
          } else {
            // Handle any other unexpected states
            return Scaffold(
              appBar: AppBar(
                title: Text('Home'),
              ),
              body: Center(
                child: Text('Unknown state'),
              ),
            );
          }
        },
      ),
    );
  }
}
// previous code that we need to handle just saving to come back to this. but if above code works dont worry about this one.
// if (user == null) {
//   // Handle the case where no arguments were passed
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Home'),
//     ),
//     body: const Center(
//       child: Text(
//           'Args were null. Type shit.'), // Display a message indicating null arguments
//     ),
//   );
// } else {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Home'),
//     ),
//     body: Center(
//       child: Text('Welcome, ${user.firstName}!'),
//     ),
//   );
// }
