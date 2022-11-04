import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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

  DevicePlatform selectedPlatform = DevicePlatform.device;
  bool useCustomTheme = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Settings'),
        ),
        body: SettingsList(platform: selectedPlatform, sections: [
          SettingsSection(
            title: const Text('Appearance'),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                onToggle: (value) {
                  setState(() {
                    useCustomTheme = value;
                  });
                },
                initialValue: useCustomTheme,
                leading: const Icon(Icons.format_paint),
                title: const Text('Dark Mode'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Application Notifications'),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: true,
                leading: const Icon(Icons.timer),
                title: const Text('Enable timer notifications'),
                description: const Text(
                    "Timer notifications are sent for when a standing session finishes"),
              ),
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: true,
                leading: const Icon(Icons.notifications_active),
                title: const Text('Enable calendar notifications'),
                description: const Text(
                    'Calendar notifications are sent 5 minutes before a scheduled standing session begins'),
              ),
            ],
          ),
        ]));
  }
}
