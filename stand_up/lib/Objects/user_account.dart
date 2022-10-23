import 'dart:convert';

class UserAccount {
  late int id;
  late String email;
  late String username;
  static final UserAccount _account = UserAccount();

  factory UserAccount() {
    return _account;
  }
  UserAccount.instantiate(this.id, this.email, this.username);
  factory UserAccount.fromRequestBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);
    return UserAccount.instantiate(json['id'], json["email"], json['username']);
  }
  void printAttributes() {
    print("id: $id\n");
    print("email: $email\n");
    print("username: $username\n");
  }
}
