import 'package:flutter/material.dart';

class TOFInfo extends StatelessWidget {
  const TOFInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            Row(
              children: const [
                Text("Info", style: TextStyle(color: Color(0xff929BAB)))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Name",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    "The Orthopedic Foundation",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "E-mail",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    "hbenjamin@theorthopedicfoundation.com",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Phone",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    "614-839-2142",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                )
              ],
            ),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: e,
                  ))
              .toList(),
        ));
  }
}
