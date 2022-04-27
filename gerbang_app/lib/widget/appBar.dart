// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import '../change_notifier/navigation.dart';
import 'package:provider/provider.dart';

class AppBarGerbang extends StatefulWidget {
  static String tag = '/AppBarGerbang';

  @override
  AppBarGerbangState createState() => AppBarGerbangState();
}

class AppBarGerbangState extends State<AppBarGerbang> {
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
    return 
    Consumer<Navigation>(builder: (context, navigation, _) 
    => Container(
      padding: EdgeInsets.only(right: 8),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2.0)], borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 50, left: 16, right: 16),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          8.width,
          TextFormField( //Search Bar
            showCursor: false,
            decoration: InputDecoration(focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, hintText: 'Search for apps & books'),
            onFieldSubmitted: (String value){
              if (navigation.selectedIndex == 0){//seach apps
                navigation.setPage = "Search Apps";
                navigation.searchValue = value;
              }
              else if (navigation.selectedIndex == 1){ //search books
                navigation.setPage = "Search Books";
                navigation.searchValue = value;
              }else{//fallback to search apps
                navigation.setPage = "Search Apps";
                navigation.searchValue = value;
              }
            },
          ).expand(),
          8.width,
          IconButton(
            icon: Icon(Icons.keyboard_voice_outlined),
            onPressed: () {},
          ),
          InkWell(
            onTap: () {
              // accountDialogBox(context);
            },
            child: CircleAvatar(maxRadius: 17, child: Text('J'), backgroundColor: Colors.purple),
          ),
        ],
      ),
    )
    );
  }
}