import 'dart:convert';
import 'package:gerbang_app/api/models/const.dart';
import 'package:http/http.dart' as http;
import 'package:gerbang_app/model/bookModel.dart';

class BookWidget {
  static Future<List<Book>> getAllBooks(int page) async {
    final response = await http.get(Uri.parse(
        route +"api/v1/product/books?page=$page&page_size=5"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      List<Book> l = [];
      for (var d in data["data"]["Items"]) {
        var subcatJson = d["subcategories"] as List;
        List<String> _subcat = subcatJson.map((e) => e as String).toList();
        l.add(Book(
          ID: d["ID"],
          Title: d["title"],
          Description: d["description"],
          ISBN: d["isbn"],
          Author: d["author"],
          Publisher: d["publisher"],
          Publish_date: d["publishDate"],
          Total_pages: d["totalPages"],
          Cover: d["cover"],
          File: d["file"],
          Pending_status: d["pendingStatus"],
          DownloadCount: d["downloadCount"],
          Subcategories: _subcat,
        ));
      }
      return l;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}