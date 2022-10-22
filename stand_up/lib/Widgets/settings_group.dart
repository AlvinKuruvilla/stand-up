import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
  final String title;
  SettingsGroup({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: headerStyle,
    );
  }
}
