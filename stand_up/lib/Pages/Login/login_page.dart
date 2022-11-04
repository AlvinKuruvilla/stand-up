import 'package:flutter/material.dart';
import 'package:stand_up/Objects/user_account.dart';
import 'package:stand_up/Pages/Login/register_page.dart';
import 'package:stand_up/Pages/Timer/timer_page.dart';
import 'package:stand_up/Services/auth_api.dart';
import 'package:stand_up/Widgets/error_flash_message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthAPI _authAPI = AuthAPI();
  final key = GlobalKey<FormState>();
  String email = "";
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
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: const [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
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
                  hintText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.person)),
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
                    var ret = await _authAPI.login(email, password);
                    var found = ret[0];
                    var username = ret[1];
                    var parsedEmail = ret[2];
                    if (found) {
                      var account = UserAccount.instantiate(
                          parsedEmail, username, password);
                      account.printAttributes();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TimerPage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: ErrorFlashMessage(
                        errorText: "Email or Password is Incorrect",
                        title: "Oh Nose! Login Failed!",
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
                "Login",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
            },
            child: const Text("Sign Up"))
      ],
    );
  }
}
