import 'package:http/http.dart' as http;
import 'dart:convert';
import 'const.dart';

class EditProfile {
  final int code;
  final String id;
  final String email;
  final String name;

  EditProfile({
    required this.code,
    required this.id,
    required this.email,
    required this.name,
  });

  static Future<EditProfile> setProfile(String id, String name, String token) async {
    Uri url = Uri.parse(route + 'api/v1/users');

    Map jsonRaw = {'id': id, 'name': name};
    var jsonBody = json.encode(jsonRaw);

    var result = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "Cookie": token
        }, body: jsonBody);

    var data = json.decode(result.body);

    if (data["code"] == 200) {
      return EditProfile(
          code: 200,
          id: data["data"]["ID"],
          email: data["data"]["Email"],
          name: data["data"]['Name']);
    }

    return EditProfile(code: 404, id: "id", email: "email", name: "name");
  }
}
