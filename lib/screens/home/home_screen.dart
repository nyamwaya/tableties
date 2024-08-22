import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:TableTies/data_models/user_supabase.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as UserSupabase?;

    if (user == null) {
      // Handle the case where no arguments were passed
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: const Center(
          child: Text(
              'Args were null. Type shit.'), // Display a message indicating null arguments
        ),
      );
    } else {
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
}
