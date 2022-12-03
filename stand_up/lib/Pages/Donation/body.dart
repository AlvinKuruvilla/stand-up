import 'package:flutter/material.dart';
import 'package:stand_up/Widgets/Donation/item_image.dart';
import 'package:stand_up/Widgets/Utilities/error_flash_message.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatelessWidget {
  // TODO: Figure out a bettter way to set the color of the Widget. It currently doesn't respect the theme switching and if we remove the Container
  // the color is unreadable
  // Maybe we can access the static variable from the ThemeController to see if it is currently dark or light mode?
  const Body({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ItemImage(),
          const Expanded(
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
    const double kDefaultPadding = 30.0;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  bottom: kDefaultPadding - 15,
                ),
                child: Column(
                  children: const <Widget>[
                    Center(
                      child: Text(
                        "The Orthopedic Foundation",
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: kDefaultPadding - 15,
                    bottom: kDefaultPadding - 15,
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'About',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: kDefaultPadding - 15,
                    bottom: kDefaultPadding - 10,
                  ),
                  child: Column(
                    children: const [
                      Text(
                        "The Orthopedic Foundation is a charitable organization dedicated to improving the quality of patient care and medical services through a commitment to research, education and prevention of orthopedic and neurologic disorders.",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              Container(
                padding: const EdgeInsets.only(
                  bottom: kDefaultPadding - 15,
                ),
                child: Column(
                  children: const [
                    Text(
                      'Contact',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding - 15,
                  bottom: kDefaultPadding - 15,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.open_in_new,
                      size: 35,
                    ),
                    InkWell(
                      onTap: () async {
                        const url = "https://www.theorthopedicfoundation.com/";
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: ErrorFlashMessage(
                            errorText: "Could not launch the provided url",
                            title: "Oh Nose! Failed to launch url!",
                          )));
                        }
                      },
                      child: const Text(
                        "www.theorthopedicfoundation.com/",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
