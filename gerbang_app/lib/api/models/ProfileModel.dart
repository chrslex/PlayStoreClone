import 'package:http/http.dart' as http;
import 'dart:convert';
import 'const.dart';

class Profile {
  final int code;
  final String id;
  final String email;
  final String name;

  Profile({
    required this.code,
    required this.id,
    required this.email,
    required this.name,
  });

  static Future<Profile> getProfile(String id) async {
    Uri url = Uri.parse(route + 'api/v1/users/' + id);

    var result = await http.get(url,
        headers: {"Content-Type": "application/json"});

    var data = json.decode(result.body);

    if (data["code"] == 200) {
      return Profile(
          code: 200,
          id: data["data"]["id"],
          email: data["data"]["email"],
          name: data["data"]['name']);
    }

    return Profile(code: 404, id: "id", email: "email", name: "name");
  }
}
