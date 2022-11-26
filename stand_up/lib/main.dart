import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:stand_up/Pages/Donation/donation_page.dart';
import 'package:stand_up/Pages/Login/login_page.dart';
import 'package:stand_up/Widgets/Calendar/event_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    Stripe.publishableKey =
        "pk_test_51M2KJ9Dmv0tllYfEngNWe1pW85Bw6dPSmD3TEDnjx8t7HwWoNMA1wC4QBiG5PRjnmUyZWTXgzYJmLf2tmeplhOxZ00L33Nd8c1";
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: OverlaySupport(
          child: MaterialApp(
        home: !kIsWeb ? const DonationPage() : const LoginPage(),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: const ColorScheme.light()),
        darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.grey.shade900,
            colorScheme: const ColorScheme.dark()),
      )));
}
