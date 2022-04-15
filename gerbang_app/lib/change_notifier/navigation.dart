import 'package:flutter/foundation.dart';

class Navigation with ChangeNotifier {
  String _page = "Login";
  String _id = "id";
  String _name = "name";
  String _email = "email";
  String _token = "token";
  String? _productName = "PRODUCT NAME";
  String? _productCover = "a";
  String? _productType = "product";
  String? _productDescription = "";
  int? _productID = 1;
  int? _productSize = 1;
  bool _showAppBar = true;
  int? _selectedIndex = -1;
  String? _searchValue = "";

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

  int? get productID => _productID;
  set productID(int? id) {
    _productID = id;
    notifyListeners();
  }

  String? get productName => _productName;
  set productName(String? name){
    _productName = name;
    notifyListeners();
  }

  int? get productSize => _productSize;
  set productSize(int? size) {
    _productSize = size;
    notifyListeners();
  }

  String? get productCover => _productCover;
  set productCover(String? cover) {
    _productCover = cover;
    notifyListeners();
  }

  String? get productType => _productType;
  set productType(String? type) {
    _productType = type;
    notifyListeners();
  }

  bool get showAppBar => _showAppBar;
  set setShowAppBar(bool show) {
    _showAppBar = show;
    notifyListeners();
  }

  String? get productDescription => _productDescription;
  set productDescription(String? description) {
    _productDescription = description;
    notifyListeners();
  }

  int? get selectedIndex => _selectedIndex;
  set selectedIndex(int? num){
    _selectedIndex = num;
    notifyListeners();
  }

  String? get searchValue => _searchValue;
  set searchValue(String? value){
    _searchValue = value;
    notifyListeners();
  }
}