import 'package:flutter/material.dart';
import 'package:gerbang_app/change_notifier/navigation.dart';
import 'package:gerbang_app/screens/exploreAllProducts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../model/bookModel.dart';
import '../widget/bookWidget.dart';
import '../widget/productWidget.dart';

class EBookList extends StatefulWidget {
  const EBookList({Key? key}) : super(key: key);

  @override
  State<EBookList> createState() => _EBookListState();
}

class _EBookListState extends State<EBookList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(),
            IndividualBookList(page: 1)
          ],
        ),
      ),
    );
  }
}

class IndividualBookList extends StatelessWidget {
  final int page;
  const IndividualBookList({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BookWidget.getAllBooks(page),
      builder: (BuildContext context,
          AsyncSnapshot<List<Book>> snapshot) {
        if (snapshot.hasData) {
          List<Book>? book = snapshot.data;
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
                          navigation.setPage = "Explore Books";
                        },
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Text(
                              "Books Cat 1",
                              style:
                                  boldTextStyle(size: 18),
                            ),
                            Icon(Icons
                                .arrow_forward_rounded),
                          ],
                        ).paddingOnly(left: 16, right: 16),
                      ),
                      16.height,
                      SingleChildScrollView(
                        padding: EdgeInsets.only(
                            left: 8, right: 8),
                        child: Row(
                            children: book!.map((Book b) {
                          return ProductWidget(
                            imgAsset: b.Cover,
                            title: b.Title,
                            size: b.Total_pages.toString(),
                            type: "book",
                            description: b.Description,
                            productID: b.ID,
                            downloadCount: b.DownloadCount
                          );
                        }).toList()),
                        scrollDirection: Axis.horizontal,
                      )
                    ]),
              ),
            ]).paddingBottom(16),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ).paddingBottom(16);
  }
}
