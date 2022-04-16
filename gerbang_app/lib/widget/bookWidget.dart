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
      for (var d in data["data"]["items"]) {
        var subcatJson = d["subcategories"] as List;
        List<String> _subcat = subcatJson.map((e) => e as String).toList();
        l.add(Book(
          ID: d["id"],
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

  static Future<List<Book>> getAllBooksByName(int page, String name) async {
    final response = await http.get(Uri.parse(
        //CHANGE ROUTE AND PARAMS LATER
        route +"api/v1/product/books?page=$page&page_size=5&?search=$name"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      List<Book> l = [];
      for (var d in data["data"]["items"]) {
        var subcatJson = d["subcategories"] as List;
        List<String> _subcat = subcatJson.map((e) => e as String).toList();
        l.add(Book(
          ID: d["id"],
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

static Future<Book> getBooksById(String id) async {
    final response = await http.get(Uri.parse(route +
        "api/v1/product/books/$id"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      List<Book> l = [];
        var subcatJson = data["data"]["subcategories"] as List;
        List<String> _subcat =
            subcatJson.map((e) => e as String).toList();
        l.add(Book(
          ID: data["data"]["id"],
          Title: data["data"]["title"],
          Description: data["data"]["description"],
          ISBN: data["data"]["isbn"],
          Author: data["data"]["author"],
          Publisher: data["data"]["publisher"],
          Publish_date: data["data"]["publishDate"],
          Total_pages: data["data"]["totalPages"],
          Cover: data["data"]["cover"],
          File: data["data"]["file"],
          Pending_status: data["data"]["pendingStatus"],
          DownloadCount: data["data"]["downloadCount"],
          Subcategories: _subcat,

        ));
      return l[0];
      }
      else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    } 
  }

}