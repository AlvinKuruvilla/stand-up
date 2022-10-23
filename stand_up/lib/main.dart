import 'package:flutter/material.dart';
import 'package:stand_up/Objects/user_account.dart';
import 'package:stand_up/Pages/Login/login_page.dart';

void main() {
  UserAccount user;
  runApp(MyApp(
    user: user,
  ));
}

class MyApp extends StatefulWidget {
  final UserAccount user;
  const MyApp({super.key, required this.user});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(user: widget.user),
    );
  }
}
