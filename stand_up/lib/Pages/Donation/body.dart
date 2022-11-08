import 'package:flutter/material.dart';
import 'package:stand_up/Widgets/Donation/donate_button.dart';
import 'package:stand_up/Widgets/Donation/item_image.dart';
import 'package:stand_up/Widgets/Donation/title_widget.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Column(
        children: const <Widget>[
          ItemImage(),
          Expanded(
            child: ItemInfo(),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemInfo extends StatelessWidget {
  const ItemInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: <Widget>[
          const TitleWidget(
            name: "The Orthopedic Foundation",
          ),
          const Center(
            child: Text(
              "The Orthopedic Foundation is a charitable organization dedicated to improving the quality of patient care and medical services through a commitment to research, education and prevention of orthopedic and neurologic disorders.",
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.1),
          // Free space  10% of total height
          DonateButton(
            size: size,
            press: () {},
          ),
          _learnMore(context)
        ],
      ),
    );
  }

  _learnMore(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //TODO: Add url launcher support
      children: [TextButton(onPressed: () {}, child: const Text("Learn More"))],
    );
  }
}
