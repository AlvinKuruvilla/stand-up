import 'package:flutter/material.dart';

class DonateButton extends StatelessWidget {
  const DonateButton({
    Key? key,
    required this.size,
    required this.press,
  }) : super(key: key);

  final Size size;
  //TODO: When the Inkwell is pressed the fake Stripe payment should begin
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      width: size.width * 0.8,
      // it will cover 80% of total width
      decoration: BoxDecoration(
        color: const Color(0xFFFFC61F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            press();
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.diamond,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  "Donate",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
