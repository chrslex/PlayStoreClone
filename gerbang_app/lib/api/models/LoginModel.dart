import 'package:http/http.dart' as http;
import 'dart:convert';
import 'const.dart';

class Login {
  final int code;
  final String id;
  final String name;
  final String email;
  final String token;

  Login({
    required this.code,
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  static Future<Login> loginUser(String email, String password) async {
    Uri url = Uri.parse(route + 'api/v1/auth/signin');

    Map jsonRaw = {'email': email, 'password': password};
    var jsonBody = json.encode(jsonRaw);

    var result = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonBody);

    var data = json.decode(result.body);
    var token = result.headers["set-cookie"];

    if (data["code"] == 200 && token != null) {

      return Login(
          code: 200,
          id: data["data"]["ID"],
          name: data["data"]["Name"],
          email: data["data"]["Email"],
          token: token);
    }

    return Login(code: 404, id: "id", name: "name", email: "email", token: "token");
  }
}
