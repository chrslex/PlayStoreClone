import 'package:http/http.dart' as http;
import 'dart:convert';

class Login {
  final String email;
  final String password;

  Login({
    required this.email,
    required this.password,
  });

  static Future<Login> loginUser(String email, String password) async {
    Uri url = Uri.parse('https://reqres.in/api/users');

    var result =
        await http.post(url, body: {'email': email, 'password': password});

    var data = json.decode(result.body);

    return Login(email: data["email"], password: data["password"]);
  }
}
