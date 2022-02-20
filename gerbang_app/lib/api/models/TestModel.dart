import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpStateful {
  String id, name, job, createdAt;

  HttpStateful(
      {required this.id,
      required this.name,
      required this.job,
      required this.createdAt});

  static Future<HttpStateful> connectAPI(String name, String job) async {
    Uri url = Uri.parse('https://reqres.in/api/users');

    var result = await http.post(url, body: {'name': name, 'job': job});

    var data = json.decode(result.body);

    return HttpStateful(id: data["id"], name: data["name"], job: data["job"], createdAt: data["createdAt"]);
  }
}
