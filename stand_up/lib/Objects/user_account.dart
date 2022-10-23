import 'dart:convert';

class UserAccount {
  int id;
  String email;
  String username;
  UserAccount({required this.id, required this.email, required this.username});

  factory UserAccount.fromRequestBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);
    return UserAccount(
        id: json['id'], email: json["email"], username: json['username']);
  }
  void printAttributes() {
    print("id: $id\n");
    print("email: $email\n");
    print("username: $username\n");
  }
}
