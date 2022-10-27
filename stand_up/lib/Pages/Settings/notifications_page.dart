import 'package:flutter/material.dart';
import 'package:stand_up/Pages/Settings/settings_page.dart';
import 'package:stand_up/Widgets/settings_option.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle headerStyle = TextStyle(
      color: Colors.grey.shade800,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Notifications and Sounds',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "APPLICATION NOTIFICATIONS",
              style: headerStyle,
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  const SettingOption("Tagging Notifications", Colors.black),
                  buildDivider(),
                  const SettingOption(
                      "New Connection Notification", Colors.black),
                  buildDivider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
