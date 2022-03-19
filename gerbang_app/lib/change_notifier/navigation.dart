import 'package:flutter/foundation.dart';

class Navigation with ChangeNotifier {
  String _page = "Login";
  String _id = "id";
  String _name = "name";
  String _email = "email";
  String _token = "token";

  String get page => _page;
  set setPage(String page) {
    _page = page;
    notifyListeners();
  }

  String get id => _id;
  set setId(String id) {
    _id = id;
    notifyListeners();
  }

  String get name => _name;
  set setName(String name) {
    _name = name;
    notifyListeners();
  }

  String get email => _email;
  set setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  String get token => _token;
  set setToken(String token) {
    _token = token;
    notifyListeners();
  }
}