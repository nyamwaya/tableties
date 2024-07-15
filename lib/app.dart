import 'package:TableTies/screens/auth/login_screen.dart';
import 'package:TableTies/screens/auth/signup_screen.dart';
import 'package:TableTies/screens/home/home_screen.dart';
import 'package:TableTies/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TableTiesApp extends StatelessWidget {
  const TableTiesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getInitialRoute(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
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
          return MaterialApp(
            home: _getHomeScreen(snapshot.data),
            routes: {
              '/onboarding': (context) => IntroScreen(),
              '/login': (context) => LoginScreen(),
              '/signup': (context) => SignUpPage(),
              // Add other routes as needed
            },
          );
        }
      },
    );
  }

  Future<String> _getInitialRoute() async {
    bool isFirstRun = await _isFirstRun();
    bool isActiveSession = await _isActiveSession();

    if (isFirstRun) {
      return '/onboarding';
    } else if (isActiveSession) {
      return '/home'; // Replace with your home route
    } else {
      return '/login';
    }
  }

  Future<bool> _isFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('first_run') ?? true;
    if (isFirstRun) {
      await prefs.setBool('first_run', false);
    }
    return isFirstRun;
  }

  Future<bool> _isActiveSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionToken = prefs.getString('session_token');
    if (sessionToken != null && sessionToken.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Widget _getHomeScreen(String? initialRoute) {
    switch (initialRoute) {
      case '/onboarding':
        return IntroScreen();
      case '/home':
        return HomePage(); // Replace with your home screen widget
      case '/login':
      default:
        return LoginScreen();
    }
  }
}
