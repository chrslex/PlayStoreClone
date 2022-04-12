// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gerbang_app/api/models/appModel.dart';
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
        l.add(App(
          ID: d["ID"],
          CreatedAt: d["CreatedAt"],
          UpdatedAt: d["UpdatedAt"],
          DeletedAt: d["DeletedAt"],
          Title: d["Title"],
          Description: d["Description"],
          File: d["File"],
          Subowner: d["Subowner"],
          Developer: d["Developer"],
          Size: d["Size"],
          Age: d["Age"],
          Icon: d["Icon"],
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
