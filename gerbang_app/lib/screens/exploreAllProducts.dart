import 'package:flutter/material.dart';
import 'package:gerbang_app/widget/bookWidget.dart';
import 'package:gerbang_app/widget/productWidget.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:nb_utils/nb_utils.dart';

import '../api/models/bookModel.dart';

class ExploreBooks extends StatefulWidget {
  static String tag = '/PSGameDetailsScreen';

  ExploreBooks({Key? key}) : super(key: key);

  @override
  ExploreBooksState createState() => ExploreBooksState();
}

class ExploreBooksState extends State<ExploreBooks> {
  List<Book> data = [];
  int currentLength = 0;
  int page = 1;
  final int increment = 5;
  bool isLoading = false;

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  Future<void> _loadMore() async {
    setState(() {
      isLoading = true;
    });
    final response = await BookWidget.getAllBooks(page);
    page += 1;
    data.addAll(response);
    setState(() {
      isLoading = false;
      currentLength = data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Explore All Products",
              style: boldTextStyle()),
        ),
        body: LazyLoadScrollView(
          onEndOfPage: () => _loadMore(),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, position) {
              return ProductWidget(
                imgAsset: data[position].Cover , 
                title: data[position].Title, 
                size: data[position].Total_pages.toString(), 
                type: "book",);
            },
          ),
        ),
      ),
    );
  }
}
