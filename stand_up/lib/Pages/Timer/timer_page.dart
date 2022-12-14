import 'package:flutter/material.dart';
import 'package:stand_up/Objects/user_account.dart';
import 'package:stand_up/Pages/Donation/donation_page.dart';
import 'package:stand_up/Pages/Settings/settings_page.dart';
import 'package:stand_up/Widgets/Calendar/calendar.dart';
import 'package:stand_up/Widgets/Timer/animated_clock.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  void initState() {
    super.initState();
  }

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
                        builder: (context) => const CalendarWidget()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text("Donate"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DonationPage()));
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
      body: const CountDownTimer(),
    );
  }
}
