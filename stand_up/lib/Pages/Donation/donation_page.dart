import 'package:flutter/material.dart';
import 'package:stand_up/Pages/Donation/body.dart';

class DonationPage extends StatelessWidget {
  //! TODO: Add stripe integration
  const DonationPage({super.key});
  @override
  Widget build(BuildContext context) {
    const kPrimaryColor = Color(0xFF035AA6);

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: detailsAppBar(),
      body: const Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    const kBackgroundColor = Color(0xFFF1EFF1);

    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: const EdgeInsets.only(left: 20.0),
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'Back'.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.shopping_bag),
          onPressed: () {},
        ),
      ],
    );
  }
}

AppBar detailsAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.blueAccent,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {},
    ),
  );
}
