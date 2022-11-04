import 'dart:convert';
import 'package:stand_up/Services/base_api.dart';
import 'package:http/http.dart' as http;

class AuthAPI extends BaseAPI {
  Future<http.Response> signUp(
      String username, String email, String password) async {
    var userData = {
      'username': username,
      'email': email,
      'password': password,
    };
    var body = jsonEncode(userData);
    // print("Sent Body:" + body);
    http.Response response = await http.post(Uri.parse(super.authPath),
        headers: super.headers, body: body);
    return response;
  }

  Future<List> login(String username, String password) async {
    bool userFound = false;
    String parsedUsername = "";
    String extractedEmail = "";
    // print("Parameter username:$username");
    // print("Parameter password: $password");
    http.Response response =
        await http.get(Uri.parse(super.allUsers), headers: super.headers);
    // print("Response Body:${response.body}");
    List<dynamic> data = jsonDecode(response.body);
    for (var element in data) {
      String parsedPassword = element["password"];
      parsedUsername = element["username"];
      extractedEmail = element["email"];
      // print("Parsed Password:$parsedPassword");
      // print("Parsed username:$parsedUsername");
      // print("Username Equality Check");
      // print(username == parsedUsername);
      // print("Password Equality Check");
      // print(password == parsedPassword);
      if (parsedPassword.trim() == password.trim() &&
          parsedUsername.trim() == username.trim()) {
        // print("User instantiated!!");
        userFound = true;
        // print("User Found is: $userFound");
      }
    }
    return Future.value([userFound, parsedUsername, extractedEmail]);
  }
}
