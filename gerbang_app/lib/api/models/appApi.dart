// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gerbang_app/model/appModel.dart';
import 'package:gerbang_app/api/models/const.dart';

class AppApi {
  static Future<List<App>> getAllApps(int page) async {
    final response = await http.get(Uri.parse(
        route + "api/v1/product/apps?page=$page&page_size=5"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      List<App> l = [];
      for (var d in data["data"]["items"]) {
        var subcatJson = d["subcategories"] as List;
        List<String> _subcat = subcatJson.map((e) => e as String).toList();
        l.add(App(
          ID: d["id"],
          Title: d["title"],
          Description: d["description"],
          Developer: d["developer"],
          Age: d["age"],
          Size: d["size"],
          Icon: d["icon"],
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
      throw Exception('Failed to load apps');
    }
  }

  static Future<List<App>> getAllAppsByName(int page, String name) async {
    final response = await http.get(Uri.parse(
        //CHANGE API ROUTE AND PARAMS LATER
        route + "api/v1/product/apps?search=$name&?page=$page&page_size=5&sort=descending"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      List<App> l = [];
      for (var d in data["data"]["items"]) {
        var subcatJson = d["subcategories"] as List;
        List<String> _subcat = subcatJson.map((e) => e as String).toList();
        l.add(App(
          ID: d["id"],
          Title: d["title"],
          Description: d["description"],
          Developer: d["developer"],
          Age: d["age"],
          Size: d["size"],
          Icon: d["icon"],
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
      throw Exception('Failed to load apps');
    }
  }

  static Future<App> getAppsById(String id) async {
    final response = await http
        .get(Uri.parse(route + "api/v1/product/apps/$id"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      List<App> l = [];
      var subcatJson =
          data["data"]["subcategories"] as List;
      List<String> _subcat =
          subcatJson.map((e) => e as String).toList();
      l.add(App(
        ID: data["data"]["id"],
        Title: data["data"]["title"],
        Description: data["data"]["description"],
        Developer: data["data"]["developer"],
        Age: data["data"]["age"],
        Size: data["data"]["size"],
        Icon: data["data"]["icon"],
        File: data["data"]["file"],
        Pending_status: data["data"]["pendingStatus"],
        DownloadCount: data["data"]["downloadCount"],
        Subcategories: _subcat,
      ));
      return l[0];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load app');
    }
  }

  static Future<List<String>?> getAppSubcategories() async {
    final response = await http.get(Uri.parse(
        route + "api/v1/subcategories?subtype=app"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      return List<String>.from(data["data"]["subcategories"] as List).map((subcategory) => subcategory).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load apps');
    }
  }

  static Future<List<App>> getAppsBySubcategory(String subcategory, int page) async {
    final response = await http.get(Uri.parse(
        route + "api/v1/product/apps?page=$page&page_size=5&subcategory=$subcategory"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      List<App> l = [];
      for (var d in data["data"]["items"]) {
        var subcatJson = d["subcategories"] as List;
        List<String> _subcat = subcatJson.map((e) => e as String).toList();
        l.add(App(
          ID: d["id"],
          Title: d["title"],
          Description: d["description"],
          Developer: d["developer"],
          Age: d["age"],
          Size: d["size"],
          Icon: d["icon"],
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
      throw Exception('Failed to load apps');
    }
  }
}
