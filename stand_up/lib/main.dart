import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:stand_up/Pages/Login/login_page.dart';
import 'package:stand_up/Widgets/Utilities/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
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
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        {
          return OverlaySupport(
              child: MaterialApp(
            home: const LoginPage(),
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                colorScheme: const ColorScheme.light()),
            darkTheme: ThemeData(
                scaffoldBackgroundColor: Colors.grey.shade900,
                colorScheme: const ColorScheme.dark()),
          ));
        }
      });
}
