import 'package:flutter/material.dart';
import 'package:stand_up/Widgets/animated_clock.dart';
import 'package:flutter/cupertino.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: const AnimatedClock(),
        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: 40),
          child: Align(
            alignment: Alignment.topLeft,
            child: FloatingActionButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(45))),
              elevation: 0.0,
              backgroundColor: Colors.white,
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.settings_solid,
                color: Colors.lightBlue,
                size: 32,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
