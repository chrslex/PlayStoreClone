// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gerbang_app/api/models/appModel.dart';
import 'package:gerbang_app/widget/appWidget.dart';
import 'package:gerbang_app/widget/productWidget.dart';
import 'package:gerbang_app/widget/bookWidget.dart';

class AppList extends StatefulWidget {
  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xffeeeeee),
          blurRadius: 1.0,
          offset: Offset(1.0, 1.0),
        ),
      ]),
      child: SingleChildScrollView(
        child: InkWell(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 10.0),
              child: Text(
                "Welcome to Gerbang Store",
                style: TextStyle(
                    color: Color(0xff616161),
                    fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 3.0),
              child: Text(
                "Explore best books and apps",
                style: TextStyle(
                    color: Color(0xff616161),
                    fontSize: 12.0),
              ),
            ),
            Container(
              height: 200,
              child: FutureBuilder(
                  future: AppWidget.getAllApps(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<App>> snapshot) {
                    if (snapshot.hasData) {
                      List<App>? book = snapshot.data;
                      return ListView(
                        scrollDirection: Axis.vertical,
                        children: book!
                            .map((App b) => ProductWidget(
                                imgAsset: b.Icon,
                                title: b.Title,
                                size: b.Size))
                            .toList(),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        )),
      ),
    );
  }
}
