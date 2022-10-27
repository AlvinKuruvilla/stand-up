import 'package:flutter/material.dart';

class SettingOption extends StatefulWidget {
  final String text;
  final Color textColor;
  const SettingOption(this.text, this.textColor, {super.key});
  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return SettingOptionState(text, textColor);
  }
}

class SettingOptionState extends State<SettingOption> {
  bool isEnabled = false;
  String text;
  Color textColor;
  SettingOptionState(this.text, this.textColor);
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: Colors.green,
      value: isEnabled,
      title: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onChanged: (val) {
        setState(() {
          isEnabled = val;
        });
      },
      inactiveTrackColor: Colors.grey,
    );
  }
}
