import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gerbang_app/api/models/bookModel.dart';

class BookWidget {
  static Future<List<Book>> getAllBooks() async {
    final response = await http.get(Uri.parse(
        "http://10.0.2.2:8000/api/v1/product/books?page=1&page_size=5"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      List<Book> l = [];
      for (var d in data["data"]["Items"]) {
        l.add(Book(
          ID: d["ID"],
          CreatedAt: d["CreatedAt"],
          UpdatedAt: d["UpdatedAt"],
          DeletedAt: d["DeletedAt"],
          Title: d["Title"],
          Description: d["Description"],
          ISBN: d["ISBN"],
          Author: d["Author"],
          Publisher: d["Publisher"],
          Publish_date: d["Publish_date"],
          Total_pages: d["Total_pages"],
          Cover: d["Cover"],
          File: d["File"],
          Subowner: d["Subowner"],
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