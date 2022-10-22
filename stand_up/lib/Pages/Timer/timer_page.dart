import 'package:flutter/material.dart';
import 'package:stand_up/Widgets/animated_clock.dart';
import 'package:stand_up/Widgets/in_progress.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: const Icon(Icons.edit_calendar),
                title: const Text("Calendar"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InProgressPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text("Donate"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InProgressPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Timer Settings"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InProgressPage()));
                },
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: const CountDownTimer());
  }
}
