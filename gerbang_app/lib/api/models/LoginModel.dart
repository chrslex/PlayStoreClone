import 'package:http/http.dart' as http;
import 'dart:convert';

class Login {
  final int code;
  final String email;
  final String token;

  Login({
    required this.code,
    required this.email,
    required this.token,
  });

  static Future<Login> loginUser(String email, String password) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/auth/signin');

    Map jsonRaw = {'email': email, 'password': password};
    var jsonBody = json.encode(jsonRaw);

    var result = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonBody);

    var data = json.decode(result.body);

    if (data["code"] == 200) {
      return Login(
          code: 200,
          email: data["data"]["token"]["email"],
          token: data["data"]["token"]["token"]);
    }

    return Login(code: 404, email: "email", token: "token");
  }
}
