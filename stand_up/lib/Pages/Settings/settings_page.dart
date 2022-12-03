import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  const IconWidget({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}

class ThemeController extends StatelessWidget {
  const ThemeController({super.key});
  static const keyDarkMode = "key-dark-mode";
  @override
  Widget build(BuildContext context) {
    return SwitchSettingsTile(
      title: "Dark Mode",
      settingKey: keyDarkMode,
      leading: const IconWidget(
        icon: Icons.dark_mode,
        color: Colors.deepPurple,
      ),
      onChange: (_) {},
    );
  }
}

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

  static const keyCalendar = "key-calendar";
  static const keyTimer = "key-timer";
  bool switchTimerNotifications = true;
  bool switchCalendarNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        //TODO: Make the text responsive to the theme see the comment in body.dart for a potential fix
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const ThemeController(),
            SettingsGroup(
                title: "Application Notifications",
                children: <Widget>[
                  SwitchSettingsTile(
                    title: "Timer Notifications",
                    settingKey: keyTimer,
                    leading: const IconWidget(
                      icon: Icons.timer,
                      color: Colors.black,
                    ),
                    onChange: (value) {
                      setState(() {
                        value = switchTimerNotifications;
                      });
                    },
                  ),
                  SwitchSettingsTile(
                    title: "Calendar Notifications",
                    settingKey: keyCalendar,
                    leading: const IconWidget(
                      icon: Icons.notifications_active,
                      color: Colors.black,
                    ),
                    onChange: (value) {
                      setState(() {
                        value = switchCalendarNotifications;
                      });
                    },
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
