import 'package:flutter/material.dart';
import 'package:stand_up/Objects/user_account.dart';
import 'package:stand_up/Pages/Timer/timer_page.dart';
import 'package:stand_up/Services/auth_api.dart';
import 'package:stand_up/Widgets/Utilities/error_flash_message.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthAPI _authAPI = AuthAPI();
  final key = GlobalKey<FormState>();
  String email = "";
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _signin(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: Text(
                "Welcome to Standup",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        const Text("Create an account to login"),
      ],
    );
  }

  _inputField(context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.email)),
            onChanged: (value) => setState(() => email = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person)),
            onChanged: (value) => setState(() => username = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.lock),
            ),
            obscureText: true,
            onChanged: (value) => setState(() => password = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              if (key.currentState!.validate()) {
                try {
                  var req = await _authAPI.signUp(email, password, username);
                  if (req.statusCode == 200) {
                    // print(req.body);
                    var account = UserAccount.fromRequestBody(req.body);
                    account.printAttributes();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TimerPage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: ErrorFlashMessage(
                      errorText: "Recieved unexpected HTTP status code",
                      title: "Oh Nose! Bad Response Code!",
                    )));
                  }
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: ErrorFlashMessage(
                    errorText: "Unable to connect to server",
                    title: "Oh Nose! Internal Server Error!",
                  )));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  _signin(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Sign In"))
      ],
    );
  }
}
