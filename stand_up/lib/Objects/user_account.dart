import 'dart:convert';

class UserAccount {
  late String email;
  late String username;
  late String password;
  static final UserAccount _account = UserAccount._internal();

  factory UserAccount() {
    return _account;
  }
  UserAccount._internal();

  UserAccount.instantiate(this.email, this.username, this.password) {
    _account.email = email;
    _account.username = username;
    _account.password = password;
  }
  factory UserAccount.fromRequestBody(String body) {
    final Map json = jsonDecode(body);
    // print("Decoded Body:" + json.toString());

    return UserAccount.instantiate(
        json["email"], json['username'], json["password"]);
  }
  void printAttributes() {
    // print("email: $email\n");
    // print("username: $username\n");
    // print("password:$password\n");
  }
}
