import 'package:TableTies/data_models/user_supabase.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the UserSupabase object from the arguments
    final user = ModalRoute.of(context)?.settings.arguments as UserSupabase;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text('Welcome, ${user.firstName}!'),
      ),
    );
  }
}
