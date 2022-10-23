class BaseAPI {
  static String base = "http://localhost:5000";
  static var api = "$base/api";
  var allUsers = "$api/users";
  var authPath = "$api/users/add";
  // more routes
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
}
