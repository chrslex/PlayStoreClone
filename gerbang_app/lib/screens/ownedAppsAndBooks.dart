// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gerbang_app/screens/ownedAppsFragment.dart';
import 'package:gerbang_app/screens/ownedBooksFragment.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../change_notifier/navigation.dart';

class OwnedAppsOrBooks extends StatefulWidget {
  OwnedAppsOrBooks({ Key? key }) : super(key: key);

  @override
  State<OwnedAppsOrBooks> createState() => _OwnedAppsOrBooksState();
}

class _OwnedAppsOrBooksState extends State<OwnedAppsOrBooks> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My apps & books',
              style: boldTextStyle()),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Consumer<Navigation>(
            builder: (context, navigation, _) =>
                ElevatedButton.icon(
                    label: const Text(''),
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      navigation.setShowAppBar = true;
                      navigation.setPage =
                          navigation.productType == "app"
                              ? "App List"
                              : "Book List";
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent)),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey))),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Color(0xFF01875f),
                  labelColor: Color(0xFF01875f),
                  unselectedLabelColor: Colors.black87,
                  isScrollable: true,
                  tabs: [
                    Padding(
                        padding:
                            EdgeInsets.only(bottom: 12),
                        child: Text('Books')),
                    Padding(
                        padding:
                            EdgeInsets.only(bottom: 12),
                        child: Text('Apps')),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            OwnedBookFragment(),
            OwnedAppsFragment(),
          ],
        ),
      ),
    );
  }
}