import 'package:flutter/material.dart';
import 'package:stand_up/Pages/Settings/notifications_page.dart';
import 'package:stand_up/Widgets/hierarchy_button.dart';
import 'package:stand_up/Widgets/settings_group.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'User Settings',
          ),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SettingsGroup(
                    title: "ACCOUNT",
                  ),
                  Card(
                      elevation: 0.5,
                      margin: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 0,
                      ),
                      child: Column(children: <Widget>[
                        const ListTile(
                          leading: CircleAvatar(
                            child: Text("AK"),
                          ),
                        ),
                        buildDivider(),
                        Card(
                          elevation: 0.5,
                          margin: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 0,
                          ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 10.0),
                              SettingsGroup(
                                title: "PRIVACY AND NOTIFICATIONS",
                              ),
                              Card(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 0,
                                ),
                                child: HierarchyButton(
                                  "Notifications and Sounds",
                                  () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const NotificationsPage();
                                    }));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]))
                ])));
  }
}

Container buildDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey.shade300,
  );
}
