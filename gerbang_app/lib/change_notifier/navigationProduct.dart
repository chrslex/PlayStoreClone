import 'package:flutter/foundation.dart';

class ProductNavProvider with ChangeNotifier {
  String _productName = "PRODUCT NAME";
  String _productCover = "a";
  String _productType = "product";
  int _productID = 1;
  int _productSize = 1;

   int get productID => _productID;
  set productID(int id) {
    _productID = id;
    notifyListeners();
  }

  String get productName => _productName;
  set productName(String name) {
    _productName = name;
    notifyListeners();
  }

  int get productSize => _productSize;
  set productSize(int size) {
    _productSize = size;
    notifyListeners();
  }

  String get productCover => _productCover;
  set productCover(String cover) {
    _productCover = cover;
    notifyListeners();
  }

  String get productType => _productType;
  set productType(String type) {
    _productType = type;
    notifyListeners();
  }
}
