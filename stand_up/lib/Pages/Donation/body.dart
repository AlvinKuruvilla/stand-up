import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stand_up/Widgets/Donation/donate_button.dart';
import 'package:stand_up/Widgets/Donation/item_image.dart';
import 'package:stand_up/Widgets/Donation/title_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Column(
        children: <Widget>[
          const ItemImage(),
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
  Map<String, dynamic>? paymentIntent;
  ItemInfo({
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
          Container(
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
                onTap: () async {
                  makePayment(context);
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
    );
  }

  _learnMore(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //TODO: Add url launcher support
      children: [TextButton(onPressed: () {}, child: const Text("Learn More"))],
    );
  }

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
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});

      ///now finally display payment sheeet
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
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

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
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
