import 'package:flutter/material.dart';

class HierarchyButton extends StatefulWidget {
  String text;
  Function onTap;
  HierarchyButton(this.text, this.onTap, {super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return HierarchyButtonState(text, onTap);
  }
}

class HierarchyButtonState extends State<HierarchyButton> {
  String text;
  Function onTap;

  HierarchyButtonState(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(
        Icons.arrow_right,
        color: Colors.black,
      ),
      title: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
      onTap: () => onTap,
    );
  }
}
