// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gerbang_app/widget/productWidget.dart';
import 'package:gerbang_app/widget/bookWidget.dart';

import 'package:gerbang_app/model/bookModel.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
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
            for (int i = 1; i < 3; i++)
              FutureContainer(page: i)
          ],
        )),
      ),
    );
  }
}

class FutureContainer extends StatelessWidget {
  final int page;
  const FutureContainer({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: FutureBuilder(
          future: BookWidget.getAllBooks(page),
          builder: (BuildContext context,
              AsyncSnapshot<List<Book>> snapshot) {
            if (snapshot.hasData) {
              List<Book>? book = snapshot.data;
              return ListView(
                scrollDirection: Axis.horizontal,
                children: book!
                    .map((Book b) => ProductWidget(
                          imgAsset: b.Cover,
                          title: b.Title,
                          size: b.Total_pages.toString(),
                          type: "book",
                          description: b.Description,
                          productID: b.ID,
                          downloadCount: b.DownloadCount,
                        ))
                    .toList(),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
