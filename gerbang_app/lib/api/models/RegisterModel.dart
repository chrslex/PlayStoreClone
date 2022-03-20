import 'package:http/http.dart' as http;
import 'dart:convert';
import 'const.dart';

class Register {
  final int code;
  final String email;
  final String password;
  final String role;

  Register(
      {required this.code,
      required this.password,
      required this.email,
      required this.role});

  static Future<Register> registerUser(
      String email, String password, String role) async {
    Uri url = Uri.parse(route + 'api/v1/auth/signup');

    Map jsonRaw = {
      'email': email,
      'password': password,
      'role': role
    };
    var jsonBody = json.encode(jsonRaw);

    var result = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonBody);

    var data = json.decode(result.body);

    print(data);
    if (data["code"] == 201) {
      return Register(
          code: 201,
          email: data["data"]["Email"],
          password: data["data"]["Password"],
          role: data["data"]["Role"]);
    }

    return Register(
        code: 409,
        email: "notfound@gmail.com",
        password: "password",
        role: "role");
  }
}
