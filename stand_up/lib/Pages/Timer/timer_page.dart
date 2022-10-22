import 'package:flutter/material.dart';
import 'package:stand_up/Widgets/animated_clock.dart';
import 'package:flutter/cupertino.dart';
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
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: const CountDownTimer(),
        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: 40),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(45))),
              elevation: 0.0,
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InProgressPage()));
              },
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
