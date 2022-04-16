import 'package:flutter/material.dart';
import 'package:gerbang_app/model/appModel.dart';
import 'package:gerbang_app/model/bookModel.dart';
import 'package:gerbang_app/utils/saveFiles.dart';
import 'package:nb_utils/nb_utils.dart';

class OwnedAppsFragment extends StatefulWidget {
  @override
  OwnedAppsFragmentState createState() =>
      OwnedAppsFragmentState();
}

class OwnedAppsFragmentState
    extends State<OwnedAppsFragment> {
  // List<PSMyAppsModel> installList = getLibraryList();
  int maxItemCount = 20;
  int? group = 1;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.height,
              Padding(
                padding: EdgeInsets.only(left: 16, top: 8),
                child: Text('Manage your apps',
                    style: boldTextStyle()),
              ),
              ListTile(
                visualDensity: VisualDensity(
                    horizontal: -4, vertical: -4),
                leading: Icon(Icons.all_inbox_sharp,
                        color: Colors.black)
                    .paddingOnly(left: 8, top: 8),
                title: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Storage',
                        style: boldTextStyle(size: 14)),
                    Text('88% used - 6.0 GB Free',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: 8),
                  color: Colors.grey,
                  height: 5,
                  width: 100,
                  alignment: Alignment.topLeft,
                  child: Container(
                          height: 5,
                          width: 210,
                          color: const Color(0xFF01875f))
                      .cornerRadiusWithClipRRect(50),
                ).cornerRadiusWithClipRRect(50),
                trailing:
                    Icon(Icons.keyboard_arrow_right_sharp),
              ),
              Divider(thickness: 1),
              ListTile(
                visualDensity: VisualDensity(
                    horizontal: -4, vertical: -4),
                onTap: () {},
                leading:
                    Icon(Icons.stars, color: blackColor)
                        .paddingOnly(left: 8),
                title: Text('Review',
                    style: boldTextStyle(size: 14)),
                trailing:
                    Icon(Icons.keyboard_arrow_right_sharp),
              ),
              Divider(thickness: 1),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 8),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text('On this device ($maxItemCount)',
                        style: boldTextStyle(size: 18)),
                    Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 32),
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 38),
                            child: Text('Alphabetical')
                                .onTap(() {}),
                          ),
                        ),
                        8.width,
                        Icon(Icons.sort).onTap(() {}),
                      ],
                    ),
                  ],
                ),
              ),
              // TBD

              FutureBuilder(
                future: InstalledBooksAndAppsDatabase
                    .instance
                    .readAllApps(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<App>> snapshot) {
                  if (snapshot.hasData) {
                    List<App>? installedBooks = snapshot.data;
                    return ListView.builder(
                      itemCount : installedBooks!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                                  installedBooks[index].Icon!,
                                  fit: BoxFit.cover,
                                  height: 40,
                                  width: 40)
                              .cornerRadiusWithClipRRect(4),
                          title: Text(
                            installedBooks[index].Title!,
                            style: secondaryTextStyle(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Row(
                            children: [
                              Text(installedBooks[index].Size!,
                                  style: secondaryTextStyle(
                                      size: 13)),
                              12.width,
                              Text(installedBooks[index].Developer!,
                                  style: secondaryTextStyle(
                                      size: 13)),
                            ],
                          ),
                          trailing: Container(
                            height: 28,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(
                                        3),
                                border: Border.all(
                                    color: Colors.grey)),
                            child: FlatButton(
                                child: Text('Open',
                                    style: TextStyle(
                                        color: Color(
                                            0xFF01875f))),
                                onPressed: () {}),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Text('No Installed Books/Apps'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
