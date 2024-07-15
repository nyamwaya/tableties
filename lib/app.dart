// lib/app.dart
import 'package:TableTies/screens/auth/login_screen.dart';
import 'package:TableTies/screens/auth/signup_screen.dart';
import 'package:TableTies/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TableTiesApp extends StatelessWidget {
  const TableTiesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isFirstRun(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              ),
            );
          } else {
            final bool isFirstRun = snapshot.data ?? true;
            return MaterialApp(
              home: isFirstRun ? IntroScreen() : LoginScreen(),
              routes: {
                '/onboarding': (context) => IntroScreen(),
                '/login': (context) => LoginScreen(),
                '/signup': (context) => SignUpPage(),
                //  '/home': (context) => ,
              },
            );
          }
        });

    // return MaterialApp(
    //   title: 'TableTies',
    //   theme: ThemeData(
    //     primarySwatch: Colors.deepOrange,
    //     inputDecorationTheme: InputDecorationTheme(
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(8),
    //       ),
    //       filled: true,
    //       fillColor: Colors.white,
    //     ),
    //     textTheme: GoogleFonts.montserratTextTheme(
    //       Theme.of(context).textTheme,
    //     ),
    //   ),
    //   initialRoute: '/',
    // routes: {
    //   '/': (context) => IntroScreen(),
    //   '/login': (context) => LoginScreen(),
    //   '/signup': (context) => SignUpPage(),
    //   //  '/home': (context) => ,
    // },
    // );
  }

  Future<bool> isFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('first_run') ?? true;
    if (isFirstRun) {
      await prefs.setBool('first_run', false);
    }
    return isFirstRun;
  }
}
