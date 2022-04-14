// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gerbang_app/model/appModel.dart';
import 'package:gerbang_app/api/models/const.dart';

class AppWidget {
  static Future<List<App>> getAllApps(int page) async {
    final response = await http.get(Uri.parse(
        route + "api/v1/product/apps?page=$page&page_size=5"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      List<App> l = [];
      for (var d in data["data"]["Items"]) {
        var subcatJson = d["Subcategories"] as List;
        List<String> _subcat = subcatJson.map((e) => e as String).toList();
        l.add(App(
          ID: d["ID"],
          Title: d["Title"],
          Description: d["Description"],
          Developer: d["Developer"],
          Age: d["Age"],
          Size: d["Size"],
          Icon: d["Icon"],
          File: d["File"],
          Pending_status: d["PendingStatus"],
          DownloadCount: d["DownloadCount"],
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
