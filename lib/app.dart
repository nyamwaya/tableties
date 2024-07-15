// lib/app.dart
import 'package:TableTies/screens/auth/login_screen.dart';
import 'package:TableTies/screens/auth/signup_screen.dart';
import 'package:TableTies/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TableTiesApp extends StatelessWidget {
  const TableTiesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableTies',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => IntroScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpPage(),
        //  '/home': (context) => ,
      },
    );
  }
}
