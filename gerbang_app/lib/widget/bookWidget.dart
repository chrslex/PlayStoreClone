import 'package:flutter/material.dart';
import 'package:gerbang_app/model/appModel.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../change_notifier/navigation.dart';
import '../model/bookModel.dart';
import '../widget/productWidget.dart';

class IndividualBookList extends StatelessWidget {
  final String subcategory;
  final List<Book> books;
  const IndividualBookList({
    Key? key,
    required this.subcategory,
    required this.books,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Navigation>(
      builder: (context, navigation, _) =>
      Column(children: [
        Container(
          child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                16.height,
                InkWell(
                  onTap: () {
                    navigation.setShowAppBar = false;
                    navigation.setSubcategory = subcategory;
                    navigation.setPage = "Explore Books";
                  },
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subcategory,
                        style: boldTextStyle(size: 18),
                      ),
                      const Icon(Icons.arrow_forward_rounded),
                    ],
                  ).paddingOnly(left: 16, right: 16),
                ),
                16.height,
                SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8),
                  child: Row(
                      children: books.length != 0 ? books.map((Book b) {
                    return ProductWidget(
                      imgAsset: b.Cover,
                      title: b.Title,
                      size: b.Total_pages.toString(),
                      type: "app",
                      description: b.Description,
                      productID: b.ID,
                      downloadCount: b.DownloadCount
                    );
                  }).toList() : [
                    Container(
                      child: Center(
                        child: Text("No Books Available"),
                      ),
                    )
                  ]
                  ),
                  scrollDirection: Axis.horizontal,
                )
              ]),
        ),
      ]).paddingBottom(16),
    );
  }
}
