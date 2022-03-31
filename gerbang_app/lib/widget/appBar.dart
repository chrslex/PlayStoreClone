// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';

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
    return Container(
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
          TextFormField(
            showCursor: false,
            decoration: InputDecoration(focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, hintText: 'Search for apps & games'),
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
    );
  }
}