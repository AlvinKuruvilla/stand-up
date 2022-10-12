import 'dart:async';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:stand_up/Pages/Timer/timer_page.dart';

class InProgressPage extends StatelessWidget {
  const InProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
      showNextButton: false,
      pages: [
        PageViewModel(
            title: "Stay Tuned",
            body: "We have something excited planned we think you'll love",
            image: Center(
              child: Image.asset(
                "assets/images/onboarding1.png",
                width: 350,
              ),
            ))
      ],
      done: const Text(
        "Go Back",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onDone: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const TimerPage())));
      },
    ));
  }
}
