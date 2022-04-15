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


class SearchBooks extends StatefulWidget {
  final String name;

  SearchBooks({Key? key, required this.name}) : super(key: key);

  @override
  SearchBooksState createState() => SearchBooksState();
}

class SearchBooksState extends State<SearchBooks>{
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
    final response = await BookWidget.getAllBooksByName(page, widget.name);
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
          title: Text("Search Result",
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
              );
            },
          ),
        ),
      ),
    );
  }
}

class SearchApps extends StatefulWidget {
  final String name;

  SearchApps({Key? key, required this.name}) : super(key: key);

  @override
  SearchAppsState createState() => SearchAppsState();
}

class SearchAppsState extends State<SearchApps> {
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
    final response = await AppWidget.getAllAppsByName(page, widget.name);
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
          title: Text("Search Result",
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
              );
            },
          ),
        ),
      ),
    );
  }
}
