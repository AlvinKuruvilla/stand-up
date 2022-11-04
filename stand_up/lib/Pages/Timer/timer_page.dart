import 'package:flutter/material.dart';
import 'package:stand_up/Objects/user_account.dart';
import 'package:stand_up/Pages/Settings/settings_page.dart';
import 'package:stand_up/Widgets/animated_clock.dart';
import 'package:stand_up/Widgets/in_progress.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.lightBlue),
                accountName: Text(
                  UserAccount().username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  UserAccount().email,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage:
                      NetworkImage("https://i.lensdump.com/i/ZVFKLm.png"),
                ),
              ),
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
                title: const Text("Settings"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                },
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: const CountDownTimer());
  }
}
