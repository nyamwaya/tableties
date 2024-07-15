// lib/screens/intro_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      controlsMargin: const EdgeInsets.all(16),
      pages: [
        PageViewModel(
          title: "Connect over Dinner",
          body:
              "Attend curated dinner gatherings with 4-8 like-minded individuals.",
          image: SvgPicture.asset("assets/images/onboarding1.svg"),
        ),
        PageViewModel(
          title: "Share Your Passions",
          body:
              "Our algorithm matches you with people who share your interests and passions.",
          image: SvgPicture.asset("assets/images/onboarding2.svg"),
        ),
        PageViewModel(
          title: "Make Genuine Connections",
          body:
              "Discover the best way to meet new people in your city for meaningful relationships.",
          image: SvgPicture.asset("assets/images/onboarding4.svg"),
        ),
      ],
      onDone: () {
        // Navigate to the main app screen or login screen
        Navigator.pushNamed(context, '/login');
      },
      onSkip: () {
        // Navigate to the main app screen or login screen
        Navigator.pushNamed(context, '/login');
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Text("Next"),
      done: const Text("Get Started",
          style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
