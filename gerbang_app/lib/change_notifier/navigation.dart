import 'package:flutter/foundation.dart';

class Navigation with ChangeNotifier {
  String _page = "Login";

  String get page => _page;
  set setPage(String page) {
    _page = page;
    notifyListeners();
  }
}