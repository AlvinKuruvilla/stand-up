import 'dart:convert';

import 'package:stand_up/Services/base_api.dart';
import 'package:http/http.dart' as http;

class AuthAPI extends BaseAPI {
  Future<http.Response> signUp(
      String username, String email, String password) async {
    var body = jsonEncode({
      'customer': {
        'username': username,
        'email': email,
        'password': password,
      }
    });

    http.Response response = await http.post(Uri.parse(super.customersPath),
        headers: super.headers, body: body);
    return response;
  }

  Future<http.Response> login(String username, String password) async {
    var body = jsonEncode({'username': username, 'password': password});

    http.Response response = await http.post(Uri.parse(super.authPath),
        headers: super.headers, body: body);

    return response;
  }
}
