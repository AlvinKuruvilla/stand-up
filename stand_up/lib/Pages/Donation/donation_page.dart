// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stand_up/Widgets/Donation/dashboard.dart';
import 'package:stand_up/Widgets/Donation/tof_info.dart';
import 'package:stand_up/Widgets/Utilities/error_flash_message.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DonationPage extends StatelessWidget {
  Map<String, dynamic>? paymentIntent;
  DonationPage({super.key});
  void toastMessage(context, bool success) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Container(
            color: success ? Colors.green : Colors.red,
            padding: const EdgeInsets.all(10),
            child: Text(
              success ? 'Payment Successful' : 'Payment Failed',
            ),
          ),
        ),
      );
  }

  Future<void> makePayment(context) async {
    try {
      paymentIntent = await createPaymentIntent('10', 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Alvin'))
          .then((value) {});

      displayPaymentSheet(context);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successful"),
                        ],
                      ),
                    ],
                  ),
                ));
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51M2KJ9Dmv0tllYfEmLk2tGvFOeoJa8MUOLvWrEk1Ff0qFtk7kEOCSYCE1StFfNy6jtp5oMIvsw8QzIhyXjzLbP7k00W2OxRB1K',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  _learnMore(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () async {
              const url = "https://www.theorthopedicfoundation.com/";
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: ErrorFlashMessage(
                  errorText: "Could not launch the provided url",
                  title: "Oh Nose! Failed to launch url!",
                )));
              }
            },
            child: const Text("Learn More"))
      ],
    );
  }

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
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const TOFDashboard(),
                const SizedBox(
                  height: 60,
                ),
                const TOFInfo(),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                // Free space  10% of total height
                Container(
                  // padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  // it will cover 80% of total width
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC61F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        if (!kIsWeb) {
                          makePayment(context);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: ErrorFlashMessage(
                            errorText:
                                "The stripe flutter plugin is not supported on web yet",
                            title: "Oh Nose! Stripe Payment Unsupported!",
                          )));
                        }
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
                ),

                _learnMore(context)
              ],
            ),
          )
        ]));
  }
}
