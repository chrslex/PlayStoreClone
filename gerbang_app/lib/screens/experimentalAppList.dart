import 'package:flutter/material.dart';
import 'package:gerbang_app/model/appModel.dart';
import 'package:gerbang_app/widget/appWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../change_notifier/navigation.dart';
import '../widget/productWidget.dart';

class EAppList extends StatefulWidget {
  const EAppList({Key? key}) : super(key: key);

  @override
  State<EAppList> createState() => _EAppListState();
}

class _EAppListState extends State<EAppList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(),
            IndividualAppList(page: 1)
          ],
        ),
      ),
    );
  }
}

class IndividualAppList extends StatelessWidget {
  final int page;
  const IndividualAppList({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppWidget.getAllApps(page),
      builder: (BuildContext context,
          AsyncSnapshot<List<App>> snapshot) {
        if (snapshot.hasData) {
          List<App>? book = snapshot.data;
          print(book);
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
                          navigation.setPage = "Explore Apps";
                        },
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Apps Cat 1",
                              style: boldTextStyle(size: 18),
                            ),
                            Icon(Icons.arrow_forward_rounded),
                          ],
                        ).paddingOnly(left: 16, right: 16),
                      ),
                      16.height,
                      SingleChildScrollView(
                        padding: EdgeInsets.only(
                            left: 8, right: 8),
                        child: Row(
                            children: book!.map((App b) {
                          return ProductWidget(
                            imgAsset: b.Icon,
                            title: b.Title,
                            size: b.Size.toString(),
                            type: "app",
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
