import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String name;
  const TitleWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: const <Widget>[
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
