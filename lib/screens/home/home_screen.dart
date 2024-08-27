import 'package:TableTies/blocs/home/home_bloc.dart';
import 'package:TableTies/data_models/user_supabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TableTies/events/home_event.dart';

import '../../state/home_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    final userId = ModalRoute.of(context)!.settings.arguments
        as String?; // Assuming user.id is a String

    // Trigger the FetchUserById event when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeBloc
          .add(FetchUserById(userId: userId)); // This should now work correctly
    });

    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeSuccess) {
          // Handle HomeSuccess state
          print('Home Success: ${state.resource.data}');
        } else if (state is HomeFailure) {
          // Handle HomeFailure state
          print('Home Failure: ${state.resource.error}');
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state is HomeSuccess) {
            final UserSupabase userModel = state.resource.data;

            return Scaffold(
                body: Center(
                    child: Text('Home Success: ${userModel.firstName}')));
          } else if (state is HomeFailure) {
            return Scaffold(
                body: Center(child: Text('Error: ${state.resource.error}')));
          } else {
            return Scaffold(body: Center(child: Text('Unknown state')));
          }
        },
      ),
    );
  }
}
