import 'package:flutter/material.dart';
import 'package:gerbang_app/api/models/appApi.dart';
import 'package:gerbang_app/widget/appWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../change_notifier/navigation.dart';
import '../model/appModel.dart';

class ExperimentalAppList extends StatelessWidget {
  ExperimentalAppList({
    Key? key,
  }) : super(key: key);
  static List<String> listSubcategory = [];

  Future<List<List<App>>> getAppList() async {
    late Future<List<String>?> subcategories = AppApi.getAppSubcategories();
    List<List<App>> appList = [];
    subcategories.then((value) => {
      listSubcategory = value!
    });

    List<App> appSubcatList;
    for (var i = 0; i < listSubcategory.length; i++) {
      appSubcatList = await AppApi.getAppsBySubcategory(listSubcategory[i], 1);
      appList.add(appSubcatList);
    }
    return appList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAppList(),
      builder: (BuildContext context,
        AsyncSnapshot<List<List<App>>> snapshot) {
        if (snapshot.hasData) {
          List<List<App>>? appList = snapshot.data;
          return Consumer<Navigation>(
            builder: (context, navigation, _) =>
            SingleChildScrollView(
              child: Column(
                children:
                [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return IndividualAppList(subcategory: listSubcategory[index], apps: appList![index]);
                      },
                  )
                ]
              )
            )
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ).paddingBottom(16);
  }
}
