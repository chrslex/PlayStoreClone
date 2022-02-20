// import 'package:gerbang_app/api/models/LoginModel.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

// Future<Login> loginUser() async {
//   final response = await http
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Login.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Faile to load users');
//   }
// }
