import 'package:flutter/material.dart';
import 'package:gerbang_app/model/appModel.dart';
import 'package:gerbang_app/widget/appWidget.dart';
import 'package:gerbang_app/widget/bookWidget.dart';
import 'package:gerbang_app/widget/productWidget.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../change_notifier/navigation.dart';
import '../model/bookModel.dart';

class ExploreBooks extends StatefulWidget {
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
          backgroundColor: const Color(0xFF01875f),
          leading: Consumer<Navigation>(
            builder: (context, navigation, _) => IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Colors.black),
              onPressed: () {
                navigation.setShowAppBar = true;
                navigation.setPage = "App/Book List";
              },
            ),
          ),
          title: Text("Explore All Products",
              style: boldTextStyle()),
        ),
        body: LazyLoadScrollView(
          onEndOfPage: () => _loadMore(),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, position) {
              return ProductWidget(
                imgAsset: data[position].Cover,
                title: data[position].Title,
                size: data[position].Total_pages.toString(),
                type: "book",
                description: data[position].Description,
                productID: data[position].ID,
                downloadCount: data[position].DownloadCount,
              );
            },
          ),
        ),
      ),
    );
  }
}

class ExploreApps extends StatefulWidget {
  ExploreApps({Key? key}) : super(key: key);

  @override
  ExploreAppsState createState() => ExploreAppsState();
}

class ExploreAppsState extends State<ExploreApps> {
  List<App> data = [];
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
    final response = await AppWidget.getAllApps(page);
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
          backgroundColor: const Color(0xFF01875f),
          leading: Consumer<Navigation>(
            builder: (context, navigation, _) => IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Colors.black),
              onPressed: () {
                navigation.setShowAppBar = true;
                navigation.setPage = "App/Book List";
              },
            ),
          ),
          title: Text("Explore All Products",
              style: boldTextStyle()),
        ),
        body: LazyLoadScrollView(
          onEndOfPage: () => _loadMore(),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, position) {
              return ProductWidget(
                imgAsset: data[position].Icon,
                title: data[position].Title,
                size: data[position].Size,
                type: "app",
                description: data[position].Description,
                productID: data[position].ID,
                downloadCount: data[position].DownloadCount,
              );
            },
          ),
        ),
      ),
    );
  }
}
