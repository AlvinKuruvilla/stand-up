import 'package:flutter/material.dart';
import 'package:stand_up/Pages/Donation/body.dart';

class DonationPage extends StatelessWidget {
  //! TODO: Add stripe integration
  const DonationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Body(),
    );
  }
}
